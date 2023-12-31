extends CharacterBody2D

var speed = 20000
var playerOrigin = Vector2()
var max_distance_to_center = 500
var current_universe = Global.current_universe
var sprite
var isMoving = false
var onetime = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	playerOrigin = self.position
	sprite = $"Player Animations"
	#playerOrigin_x = self.position.x
	#playerOrigin_y = self.position.y
	
	
func _process(_delta):
	if onetime:
		_setAnim(Global.universe1)
		onetime = false
	if Input.is_action_just_pressed("R"):
		if "R" == Global.universe1 or "R" == Global.universe2: 
			_setAnim("R")
	if Input.is_action_just_pressed("G"):
		if "G" == Global.universe1 or "G" == Global.universe2: 
			_setAnim("G")
	if Input.is_action_just_pressed("B"):
		if "B" == Global.universe1 or "B" == Global.universe2: 
			_setAnim("B")
	if Input.is_action_just_pressed("P"):
		if "P" == Global.universe1 or "P" == Global.universe2: 
			_setAnim("P")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed("down"):
		isMoving = true
		_setAnim(Global.current_universe)
		velocity.y += 1
	if Input.is_action_just_pressed("up"):
		isMoving = true
		_setAnim(Global.current_universe)
		velocity.y -= 1
	if Input.is_action_just_pressed("left"):
		isMoving = true
		_setAnim(Global.current_universe)
		velocity.x -= 1
		sprite.set_flip_h(false) 
	if Input.is_action_just_pressed("right"):
		isMoving = true
		_setAnim(Global.current_universe)
		velocity.x += 1
		sprite.set_flip_h(true)
		
	if Input.is_action_just_released("down"):
		isMoving = false
		_setAnim(Global.current_universe)
	if Input.is_action_just_released("up"):
		isMoving = false
		_setAnim(Global.current_universe)
	if Input.is_action_just_released("left"):
		isMoving = false
		_setAnim(Global.current_universe)
	if Input.is_action_just_released("right"):
		isMoving = false
		_setAnim(Global.current_universe)
		
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
			
func _setAnim(universe):
	if !isMoving:
		if universe == "R":
			$"Player Animations".play("1 R")
		if universe == "G":
			$"Player Animations".play("Punk_Character_Idle")
		if universe == "B":
			$"Player Animations".play("3 B")
		if universe == "P":
			$"Player Animations".play("4 P")
			# apply = false
	else:
		if universe == "R":
			$"Player Animations".play("Realism_Character")
		if universe == "G":
			$"Player Animations".play("Punk_Character_Attack")
		if universe == "B":
			$"Player Animations".play("WC_Character_Attack")
		if universe == "P":
			$"Player Animations".play("EDM_Character")
			# apply = false
	if Global.current_universe != universe:
		Global.current_universe = universe
		print("i ran on ready")
