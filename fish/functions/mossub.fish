function mossub --description 'Subscribe to MQTT topic [host topic]'
	mosquitto_sub -h $argv[1] -t $argv[2]
end
