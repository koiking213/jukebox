#!/bin/bash -x
CWD=`dirname "${0}"`
source $CWD/config

{
    IFS=$'\n'
    for tune in `cat list | sort -R`
    do
	mplayer "$tune">&/dev/null
    done
}&

while :
do
    sleep 1
    if [ -e $TMP/signal ]; then
	case `cat signal` in
	    skip)
		killall mplayer
		rm signal
		;;
	    stop)
		kill `jobs -p`
		killall mplayer
		rm signal
		exit
		;;
	    *)
		echo "error: no such signal"
		;;
	esac
    fi
done


