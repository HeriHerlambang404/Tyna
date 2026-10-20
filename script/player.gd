extends CharacterBody2D

const SPEED = 220.0
@onready var player_ui: AnimatedSprite2D = $AnimatedSprite2D

# Kita simpen arah hadap aja buat fitur interaksi lainnya nanti
var facing_direction: Vector2 = Vector2.DOWN 

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity = direction * SPEED
		
		# Simpan arah hadap
		if abs(direction.x) > abs(direction.y):
			facing_direction = Vector2(sign(direction.x), 0)
		else:
			facing_direction = Vector2(0, sign(direction.y))
			
		player_ui.animation = "kanan"
		
		if direction.x != 0:
			player_ui.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		player_ui.animation = "idle"

	move_and_slide()
