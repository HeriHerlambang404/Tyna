extends CanvasLayer

@onready var clock_label = $ClockLabel
@onready var fade_screen = $FadeScreen
@onready var sleep_popup = $SleepPopup

# Tambahan: Ambil referensi ke tas (Pastikan huruf besar kecilnya sama dengan nama Node di scene)
@onready var backpack_ui = $BackpackUI

# Pakai get_node_or_null biar gak error/crash kalau node ini gak ada di scene (misal di halaman)
@onready var player = get_node_or_null("../player") 
@onready var wake_up_point = get_node_or_null("../BedArea/WakeUpPoint")

func _ready():
	sleep_popup.hide()
	fade_screen.color.a = 0
	# Pastikan tas ketutup pas game baru mulai
	if backpack_ui:
		backpack_ui.hide()

func _process(_delta):
	# Selalu ambil teks jam dari Autoload GlobalTime
	clock_label.text = "%02d:%02d" % [GlobalTime.hour, int(GlobalTime.minute)]

func show_sleep_prompt():
	sleep_popup.show()
	get_tree().paused = true 

func _on_no_button_pressed():
	sleep_popup.hide()
	get_tree().paused = false

func _on_yes_button_pressed():
	sleep_popup.hide()
	start_sleeping_transition()

func start_sleeping_transition():
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) 
	tween.tween_property(fade_screen, "color:a", 1.0, 1.5)
	
	await tween.finished
	
	# === UPDATE WAKTU KE AUTOLOAD ===
	GlobalTime.hour = 6
	GlobalTime.minute = 0.0
	
	if player and wake_up_point:
		player.global_position = wake_up_point.global_position
		var player_sprite = player.get_node("AnimatedSprite2D")
		if player_sprite:
			player_sprite.play("idle")
			player_sprite.flip_h = true
			player.velocity = Vector2.ZERO 
	
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false
	
	var tween_back = create_tween()
	tween_back.tween_property(fade_screen, "color:a", 0.0, 1.5)
	
func _input(event):
	# --- LOGIKA BUKA TUTUP BACKPACK ---
	if event.is_action_pressed("toggle_inventory"):
		if backpack_ui:
			if backpack_ui.visible:
				# Kalau tas lagi kebuka, kita TUTUP
				backpack_ui.hide()
				get_tree().paused = false # Lanjutin game
			else:
				# Kalau tas lagi ketutup, kita BUKA
				backpack_ui.show()
				get_tree().paused = true # Pause game (waktu & player berhenti)
		else:
			print("Node BackpackUI belum ada bro! Bikin dulu ColorRect namanya BackpackUI.")

	# --- LOGIKA HOTBAR 1 SAMPAI 5 ---
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			change_hotbar_slot(0)
		elif event.keycode == KEY_2:
			change_hotbar_slot(1)
		elif event.keycode == KEY_3:
			change_hotbar_slot(2)
		elif event.keycode == KEY_4:
			change_hotbar_slot(3)
		elif event.keycode == KEY_5:
			change_hotbar_slot(4)

func change_hotbar_slot(slot_index: int):
	# Update data di Autoload
	GlobalInventory.active_hotbar_slot = slot_index
	print("Pegang slot ke: ", slot_index + 1)
	
	# Nanti di sini kita tambahin kode buat ngubah warna kotak UI-nya 
	# biar ketahuan kotak mana yang lagi dipilih
