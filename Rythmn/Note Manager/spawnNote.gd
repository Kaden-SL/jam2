extends Node2D
var note = preload("res://Rythmn/Notes/note.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = note.instantiate()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
