#set terminal pngcairo size 1000,600
#set term wxt size 1360,768
set term qt size 10000,10000

set term qt title 'ezChromato'

#set xrange [0:10200]
set xrange [0:ezrange]
set yrange [0:1]

# Set linestyle 1 to blue (#0060ad)
set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0

plot acquisition_in_progress  with linespoints linestyle 1

while (1) {
    replot
    pause 1
}
