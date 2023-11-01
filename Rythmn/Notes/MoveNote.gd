extends Area2D
@export var speed = 100.0;
var centerScreen = Vector2(1000,1000)
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
		queue_free()
