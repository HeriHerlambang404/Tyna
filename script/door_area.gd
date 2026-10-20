extends Area2D

# @export bikin variabel ini muncul di Inspector!
# Jadi lo tinggal drag & drop scene tujuan tanpa ngoding lagi.
@export var next_scene_path: String = ""

var player_in_range = false

func _on_body_entered(body):
	if body.name == "player":
		player_in_range = true
		print("Karakter di depan pintu. Tekan Space/Enter untuk keluar.")

func _on_body_exited(body):
	if body.name == "player":
		player_in_range = false
		print("Karakter menjauh dari pintu.")

func _process(_delta):
	# Kalau player di area pintu, mencet tombol, DAN jalurnya udah diisi
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		if next_scene_path != "":
			print("Pindah ruangan dengan transisi...")
			
			# --- INI PERUBAHANNYA ---
			# Kita panggil Autoload SceneTransition yang udah dibikin
			SceneTransition.change_scene(next_scene_path)
			
			# Set false biar player gak bisa neken tombol berkali-kali 
			# pas layar lagi proses fade out (biar gak error numpuk)
			player_in_range = false 
			# ------------------------
			
		else:
			print("ERROR: Jalur scene tujuan belum diisi di Inspector!")
