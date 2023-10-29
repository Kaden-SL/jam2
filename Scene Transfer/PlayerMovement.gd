extends StaticBody2D

var speed = 150
var velocity = Vector2()
var playerOrigin_x
var playerOrigin_y
# Called when the node enters the scene tree for the first time.
func _ready():
	playerOrigin_x = self.position.x
	playerOrigin_y = self.position.y
	pass # Replace with function body.
	
func _process(_delta):
	if Input.is_action_just_pressed("R"):
		$Sprite2D/AnimatedSprite2D.play("R")
	if Input.is_action_just_pressed("G"):
		$Sprite2D/AnimatedSprite2D.play("G")
	if Input.is_action_just_pressed("B"):
		$Sprite2D/AnimatedSprite2D.play("B")
	if Input.is_action_just_pressed("P"):
		$Sprite2D/AnimatedSprite2D.play("P")

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
	pass
