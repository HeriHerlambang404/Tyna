extends Area2D

var player_in_range = false
# Sesuaikan path-nya ke node GameUI lo
@onready var game_ui = get_node("../GameUI") 

func _on_body_entered(body):
	if body.name == "player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		# Minta GameUI buat munculin popup
		game_ui.show_sleep_prompt()
