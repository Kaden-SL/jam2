extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuMusic.play()	

func _on_button_pressed():
	$MenuMusic.stop()
	get_tree().change_scene_to_file("res://01 Final Draft/Tutorial Narrative/tutorial.tscn")

