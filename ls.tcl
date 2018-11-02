set ns [new Simulator]

set nf [open link.nam w]
$ns namtrace-all $nf
set tr [open link.tr w]
$ns trace-all $tr

proc finish {} {
	global nf ns tr
	$ns flush-trace
	close $tr
	exec nam link.nam &
	exec awk -f p01_throughput.awk out.tr > out.gr
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns duplex-link $n0 $n3 10Mb 10ms DropTail
$ns duplex-link $n0 $n4 10Mb 10ms DropTail
$ns duplex-link $n0 $n5 10Mb 10ms DropTail

$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n3 10Mb 10ms DropTail
$ns duplex-link $n1 $n4 10Mb 10ms DropTail
$ns duplex-link $n1 $n5 10Mb 10ms DropTail

$ns duplex-link $n2 $n3 10Mb 10ms DropTail
$ns duplex-link $n2 $n4 10Mb 10ms DropTail
$ns duplex-link $n2 $n5 10Mb 10ms DropTail

$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns duplex-link $n3 $n5 10Mb 10ms DropTail

$ns duplex-link $n4 $n5 10Mb 10ms DropTail


set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

set udp [new Agent/UDP]
$ns attach-agent $n2 $udp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null

$ns connect $tcp $sink
$ns connect $udp $null
#temporarily down the links
$ns rtmodel-at 1.0 down $n3 $n2
$ns rtmodel-at 1.5 down $n0 $n3
$ns rtmodel-at 2.0 down $n3 $n4
$ns rtmodel-at 2.2 down $n1 $n3
$ns rtmodel-at 2.5 down $n2 $n5
$ns rtmodel-at 2.5 down $n0 $n5
$ns rtmodel-at 3.0 up $n2 $n3
$ns rtproto LS
$ns at 0.0 "$ftp start"
$ns at 0.0 "$cbr start"
$ns at 4.5 "finish"
$ns run
