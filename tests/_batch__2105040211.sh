s=./test-compo-three-v2-dev-args.sh;sr=96;st=16;c=1;for i in $(seq 1 120) ; do $s $sr 192 1024 1700 $c;c=$(expr $c + 1);sr=$(expr $sr + $st); done

