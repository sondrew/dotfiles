function mossub
	mosquitto_sub -h $argv[1] -t $argv[2]
end
