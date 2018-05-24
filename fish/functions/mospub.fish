function mospub
	mosquitto_pub -h $argv[1] -t $argv[2] -m $argv[3]
end
