extends CharacterBody2D

var speed = 20000
var playerOrigin = Vector2()
var max_distance_to_center = 500
#var speed = 250
#var playerOrigin_x
#var playerOrigin_y
var current_universe = Global.current_universe
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	playerOrigin = self.position
	sprite = $"Player Animations"
	#playerOrigin_x = self.position.x
	#playerOrigin_y = self.position.y
	
func _process(_delta):
	if Input.is_action_just_pressed("R") && Global.sceneTiming == false:
		$"Player Animations".play("1 R")
		Global.current_universe = "R"
	if Input.is_action_just_pressed("G") && Global.sceneTiming == false:
		$"Player Animations".play("2 G")
		Global.current_universe = "G"
	if Input.is_action_just_pressed("B") && Global.isHalfwayThroughSong == true && Global.sceneTiming == true:
		$"Player Animations".play("3 B")
		Global.current_universe = "B"
	if Input.is_action_just_pressed("P") && Global.isHalfwayThroughSong == true && Global.sceneTiming == true:
		$"Player Animations".play("4 P")
		Global.current_universe = "P"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed("down"):
		velocity.y += 1
	if Input.is_action_just_pressed("up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("left"):
		velocity.x -= 1
		sprite.set_flip_h(false) 
	if Input.is_action_just_pressed("right"):
		velocity.x += 1
		sprite.set_flip_h(true)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	
	self.position += velocity
	
	if self.position.distance_to(playerOrigin) > max_distance_to_center:
		self.position = playerOrigin
		
	if not Input.is_action_pressed("down") and not Input.is_action_pressed("up") and not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		self.position = playerOrigin
	
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		await get_tree().create_timer(0.1).timeout
		if Global.isTouchingNote == false:
			Global.missedNotes -= 1;
		else:
			Global.isTouchingNote = false;
