function mospub --description 'Publish MQTT message [host topic message]'
	mosquitto_pub -h $argv[1] -t $argv[2] -m $argv[3]
end
