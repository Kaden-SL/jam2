extends CharacterBody2D

#var speed = 250
var speed = 10000
#var playerOrigin_x
#var playerOrigin_y
var playerOrigin = Vector2()
var max_distance_to_center = 500
var current_universe = Global.current_universe

# Called when the node enters the scene tree for the first time.
func _ready():
	#playerOrigin_x = self.position.x
	#playerOrigin_y = self.position.y
	playerOrigin = self.position
	
func _process(_delta):
	if Input.is_action_just_pressed("R"):
		$Sprite2D/AnimatedSprite2D.play("1 R")
		Global.current_universe = "R"
	if Input.is_action_just_pressed("G"):
		$Sprite2D/AnimatedSprite2D.play("2 G")
		Global.current_universe = "G"
	if Input.is_action_just_pressed("B"):
		$Sprite2D/AnimatedSprite2D.play("3 B")
		Global.current_universe = "B"
	if Input.is_action_just_pressed("P"):
		$Sprite2D/AnimatedSprite2D.play("4 P")
		Global.current_universe = "P"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed("down"):
		#self.position.y += speed
		velocity.y += 1
	#if Input.is_action_just_released("down"):
		#self.position.y = playerOrigin_y
		#self.position.x = playerOrigin_x
	if Input.is_action_just_pressed("up"):
		velocity.y -= 1
		#self.position.y -= speed
	#if Input.is_action_just_released("up"):
		#self.position.y = playerOrigin_y
		#self.position.x = playerOrigin_x
	if Input.is_action_just_pressed("left"):
		velocity.x -= 1
	#if Input.is_action_just_released("left"):
		#self.position.y = playerOrigin_y
		#self.position.x = playerOrigin_x
	if Input.is_action_just_pressed("right"):
		velocity.x += 1
		#self.position.x += speed
	#if Input.is_action_just_released("right"):
		#self.position.y = playerOrigin_y
		#self.position.x = playerOrigin_x
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	
	self.position += velocity
	
	if self.position.distance_to(playerOrigin) > max_distance_to_center:
		self.position = playerOrigin
		
	if not Input.is_action_pressed("down") and not Input.is_action_pressed("up") and not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		self.position = playerOrigin
	pass
