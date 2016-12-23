#!/usr/bin/perl

die "Please supply file name !" if (!$ARGV[0]) ;


$ind=0;
$per='\%';
$INFILE=$ARGV[$ind++];

$inlist=0;
$insuplist=0;
$inenum=0;
open(IN,"$INFILE");

$REQT="";

while(<IN>) {


   next if (/ESA UNCLASSIFIED/);
    if (/^[TQSM]-.+-[0-9]+/) {
        print "\\end{itemize}\n" if ($inlist);
        print "\\end{itemize}\n" if ($insuplist);
        print "\\end{enumerate}\n" if ($inenum);
        $inlist=0;
        $inenum=0;
        if ($inreq) {
                print "}\n";
        }
        $inreq=0;

	# requirement
	s/\r//g;
	s/\n//g;
	@req=split(/-/);
	if ( @req[1] ne $REQT ) {
	   print "\\newreqtype{@req[0]-@req[1]} \n";
	   $REQT=@req[1];
	}
        $theReq="$_";
	print "%$theReq is the old requirement \n";	
	print "\\req [$theReq ]";	
	$_=<IN>;chomp;
	s/\:/\./g;
	s/[\r\n]//g;
	$ver=$_;
        print "{$ver} ";
	$_=<IN>;chomp;
	s/[\r\n]//g;
	$type=$_;
        print "{}";
	$_=<IN>;chomp;
	s/[\r\n]//g;
	$prio=$_;
        print "{$prio}";
	$_=<IN>;chomp;
	s/[\r\n]//g;
	$test=$_;
        print "{$test}";
	$_=<IN>;chomp;
	s/[\r\n]//g;
	$status=$_;
        print "{$status}";
	$inreq=1;
	#print "\\req [$theReq]{$ver}{}{$prio}{$test}{$status}{\n";	
	print "{ \n";	
	# skip line tha says Description
	$_=<IN>;chomp;
	s/[\r\n]//g;
	# get next line for reoainder of script
	$_=<IN>;chomp;
	s/[\r\n]//g;

    }

# Deal with bullet lists ..
    if (/^\*\s/ && !$inlist){
	$inlist =1;
	print "\\begin{itemize}\n";
    }
    if (!/^\*\s/ && $inlist){
	$inlist=0;
	print "\\end{itemize}\n";
    }

    if (/^\?\s/ && !$insuplist){
	$insuplist =1;
	print "\\begin{itemize}\n";
    }
    if (!/^[\*\?]\s/ && $insuplist){
	$insuplist=0;
	print "\\end{itemize}\n";
    }

    if (/^[\*\?]\s/ && ($inlist || $insuplist)){
	s/^[\*\?]/\\item/; # only one substitution
    }
 


# Deal with enumerated lists ..
    if (/^1\./){
	$inenum =1;
	print "\\begin{enumerate}\n";
    }

    if (/^[1-9]\./ && $inenum) {
	s/^[1-9]\./\\item /g;
    }

    s/\&/\\&/g;

    s/<sub>/\$_{/g;
    s/<\/sub>/}\$/g;

   s/&omega\;/\$\\omega\$/g;
   s/&epsilon\;/\$\\epsilon\$/g;
   s/&mu\;/\$\\mu\$/g;
   s/&ndash\;/-/g;

    s/\\\$/\$/g; # why does the above leave in a \ ??

    s/^([1-9]+)([A..Z])/$1  $2/g;
    s/^[1-9][0-9]*[\t, ]+(.+)/\\section{$1}/g;
    s/^[1-9][0-9]*\.[1-9][0-9]*\s+(.+)/\\subsection{$1}/g;
    s/^[1-9][0-9]*\.[1-9][0-9]*\.[1-9][0-9]*\s+(.+)/\\subsubsection{$1}/g;

    s/^[1-9][0-9]*\.(.+)/\\section{$1}/g;

    
  
    if (/^ *$/ || /section{/ || /PA Act/) {
	print "\\end{itemize}\n" if ($inlist);
	print "\\end{itemize}\n" if ($insuplist);
	print "\\end{enumerate}\n" if ($inenum);
	$inlist=0;
	$inenum=0;
	if ($inreq) {
		print "}\n";	
	}
	$inreq=0;
    }
    if (/section{/) {
    chomp;
	$title=$_;
	$title=~s/^.*section{(.*)}/$1/g;
	$title=~s/ //g;
	s/section{(.*)}/section{$1 \\label{sect:$title}}\n/g;
	$_="\n$_";
    }

# Some refs - may need mods ..
s/\[RD1\]/\\cite{RNC-CNES-Q-80-509}/g;
s/\[RD2\]/\\cite{ecss:pa}/g;
s/\[RD3\]/\\cite{ecss:swreq}/g;
s/\[RD4\]/\\cite{ecss:e10}/g;
s/\[RD5\]/\\cite{LL:JSH-006}/g;
s/\[RD6\]/\\cite{LL:spmcm}/g;
s/\[RD7\]/\\cite{ecss:spmdoc}/g;
s/\[AD1\]/\\cite{LL:WOM-011}/g;
s/\[AD2\]/\\cite{LL:WOM-001}/g;

s/NOTE(:*)/\{\\bf NOTE:\}/;
s/PA Activities(:*)/\\newline {\\bf PA Activities:\}\\newline/i; # ignore case

# Strange chars
  s/_/\\_/g;
  s/#/\\#/g;

    
   print $_;
   
}

close(IN);




