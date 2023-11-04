extends Area2D
@export var speed = 500.0;
var centerScreen = Vector2(1000,1000)
var current_universe = Global.current_universe

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move note position towards the center of the screen
	position = position.move_toward(centerScreen, delta * speed)
	if position == centerScreen:
		queue_free()
	
	# Syncs the note sprite with the universe background
	if Global.note_universe == "R":
		$Sprite2D/AnimatedSprite2D.animation = "1 R"
		_switch_groups("R","P")
	if Global.note_universe == "B":
		$Sprite2D/AnimatedSprite2D.animation = "3 B"
		_switch_groups("B","R")
	if Global.note_universe == "G":
		$Sprite2D/AnimatedSprite2D.animation = "2 G"
		_switch_groups("G","B")
	if Global.note_universe == "P":
		$Sprite2D/AnimatedSprite2D.animation = "4 P"
		_switch_groups("P","G")
		
func _on_body_entered(body):
	# if the notes touch the player, and the player is in the correct universe: hit the note
	if body.is_in_group("Player"):
		if self.is_in_group(Global.current_universe) and self.is_in_group("Miss") == false:
				queue_free()
				if self.is_in_group("Perfect"):
					Global.bossHealth -= 2
				else:
					Global.bossHealth -= 1
				print("PlayerHit")

				if Global.bossHealth == 0:
					print("boss dead")

	if body.is_in_group("DeathBox"):
		print("DeathBoxHit")
		Global.missedNotes -= 1
		if Global.missedNotes == 0:
			print("dead")

# switches notes to be in correct universe
func _switch_groups(NG,OG):
	if self.is_in_group(OG):
		self.remove_from_group(OG)
	if self.is_in_group(NG) == false:
		self.add_to_group(NG)


func _on_area_entered(area):
	if area.is_in_group("Perfect"):
		self.add_to_group("Perfect")
		
	if area.is_in_group("Good"):
		self.remove_from_group("Perfect")
		self.add_to_group("Good")
		
	if area.is_in_group("Miss"):
		self.remove_from_group("Good")
		self.add_to_group("Miss")
