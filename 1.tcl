set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
set tf [open out.tr w]
$ns trace-all $tf
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam out.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
$ns duplex-link $n0 $n2 4Mb 10ms DropTail
$ns duplex-link $n1 $n2 4Mb 10ms DropTail
$ns queue-limit $n0 $n2 4
$ns queue-limit $n1 $n2 5
set tcp0 [new Agent/TCP]
set udp1 [new Agent/UDP]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $udp1
set null0 [new Agent/Null]
set sink0 [new Agent/TCPSink]
$ns attach-agent $n2 $sink0
$ns attach-agent $n2 $null0
$ns connect $tcp0 $sink0
$ns connect $udp1 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $tcp0
$cbr0 set rate_ 1Mb
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set rate_ 1Mb
$ns at 0.1 "$cbr1 start"
$ns at 0.4 "$cbr0 start"
$ns at 4.3 "$cbr1 stop"
$ns at 4.4 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run
