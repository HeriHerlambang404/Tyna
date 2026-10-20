extends Node

var hour: int = 6
var minute: float = 0.0
var time_speed: float = 1.0 

func _process(delta):
	# Waktu akan selalu bertambah di mana pun player berada
	minute += delta * time_speed
	
	if minute >= 60.0:
		minute = 0.0
		hour += 1
		if hour >= 24:
			hour = 0
