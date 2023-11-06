extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://01 Final Draft/Scenes/01-Main/Final Draft.tscn")

func _on_button_2_pressed():
	get_tree().quit()
