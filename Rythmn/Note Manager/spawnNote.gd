extends Node2D
var note = preload("res://Rythmn/Notes/note.tscn")
# preload the note assete

# set spawnpoint positions for the notes
var left = Vector2(0,324);
var right = Vector2(1152,324);
var up = Vector2(576,0); 
var down = Vector2(576,648);

#hold a wait time for each note
var waitTime = 0;

# this is an array where each note is stored.
# position, universe color, wait time, 
var songNotes = [["down","R",1],["left","R",1]]

# Get a list of the active notes instances
var activeSongNotes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for x in songNotes:
		var instance = note.instantiate()
		for y in range(x.size()):
			# set position of note
			if y == 0:
				if x[y] == "left":
					instance.position = left;
				if x[y] == "right":
					instance.position = right;
				if x[y] == "up":
					instance.position = up;
				if x[y] == "down":
					instance.position = down;
			# set color of note (not implemented)
			if y == 1:
				pass
			# make the code wait before spawining the note
			if y == 2:
				await get_tree().create_timer(x[y]).timeout
				add_child(instance)
				
func _process(delta):
	pass
