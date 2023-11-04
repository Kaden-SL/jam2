extends CharacterBody2D

var speed = 250
var playerOrigin_x
var playerOrigin_y
var current_universe = Global.current_universe

# Called when the node enters the scene tree for the first time.
func _ready():
	playerOrigin_x = self.position.x
	playerOrigin_y = self.position.y
	pass # Replace with function body.
	
func _process(_delta):
	if Input.is_action_just_pressed("R"):
		$"Player Animations".play("1 R")
		Global.current_universe = "R"
	if Input.is_action_just_pressed("G"):
		$"Player Animations".play("2 G")
		Global.current_universe = "G"
	if Input.is_action_just_pressed("B"):
		$"Player Animations".play("3 B")
		Global.current_universe = "B"
	if Input.is_action_just_pressed("P"):
		$"Player Animations".play("4 P")
		Global.current_universe = "P"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed("down"):
		self.position.y += speed
	if Input.is_action_just_released("down"):
		self.position.y = playerOrigin_y
		self.position.x = playerOrigin_x
	
	if Input.is_action_just_pressed("up"):
		self.position.y -= speed
	if Input.is_action_just_released("up"):
		self.position.y = playerOrigin_y
		self.position.x = playerOrigin_x
	
	if Input.is_action_just_pressed("left"):
		self.position.x -= speed
	if Input.is_action_just_released("left"):
		self.position.y = playerOrigin_y
		self.position.x = playerOrigin_x
	
	if Input.is_action_just_pressed("right"):
		self.position.x += speed
	if Input.is_action_just_released("right"):
		self.position.y = playerOrigin_y
		self.position.x = playerOrigin_x
	
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		await get_tree().create_timer(0.1).timeout
		if Global.isTouchingNote == false:
			Global.missedNotes -= 1;
		else:
			Global.isTouchingNote = false;
