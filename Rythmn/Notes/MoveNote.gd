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

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if self.is_in_group("R"):
			if Global.current_universe == "R":
				queue_free()
				Global.bossHealth -= 1
				print("PlayerHit")
				if Global.bossHealth == 0:
					print("dead")
		# Make more of these to detect universes aligning
	if body.is_in_group("DeathBox"):
		print("DeathBoxHit")
		Global.missedNotes -= 1
		if Global.missedNotes == 0:
			print("dead")
