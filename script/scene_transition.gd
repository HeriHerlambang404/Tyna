extends CanvasLayer

@onready var color_rect = $ColorRect

func change_scene(target_path: String) -> void:
	# 1. Animasi layar jadi gelap (Fade Out) selama 0.5 detik
	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, 0.5)
	
	# Tunggu sampai layar benar-benar hitam
	await tween.finished
	
	# 2. Ganti Scene!
	get_tree().change_scene_to_file(target_path)
	
	# (Opsional) Kasih jeda dikit biar gak terlalu buru-buru
	await get_tree().create_timer(0.2).timeout
	
	# 3. Animasi layar jadi terang lagi (Fade In)
	var tween_back = create_tween()
	tween_back.tween_property(color_rect, "color:a", 0.0, 0.5)
