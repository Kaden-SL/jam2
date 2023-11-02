extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start()
	$Sprite2D.visible = true
	$Sprite2D2.visible = false
	$Sprite2D3.visible = false
	$Sprite2D4.visible = false
	switchBG()

func switchBG():
	await get_tree().create_timer(1.4).timeout
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	await get_tree().create_timer(1.4).timeout
	$Sprite2D2.visible = false
	$Sprite2D3.visible = true
	await get_tree().create_timer(1.4).timeout
	$Sprite2D3.visible = false
	$Sprite2D4.visible = true
	await get_tree().create_timer(1.4).timeout
	$Sprite2D4.visible = false
	$Sprite2D.visible = true
	await get_tree().create_timer(1.4).timeout
	$Sprite2D4.visible = false
	$Sprite2D.visible = true
	switchBG()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#$Sprite2D.visible = true
	#switchBG()
	
func goR():
	$Sprite2D.visible = true
	$Sprite2D2.visible = false
	$Sprite2D3.visible = false
	$Sprite2D4.visible = false
func goG():
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	$Sprite2D3.visible = false
	$Sprite2D4.visible = false
func goB():
	$Sprite2D.visible = false
	$Sprite2D2.visible = false
	$Sprite2D3.visible = true
	$Sprite2D4.visible = false
func goP():
	$Sprite2D.visible = false
	$Sprite2D2.visible = false
	$Sprite2D3.visible = false
	$Sprite2D4.visible = true
	
"""
func _on_timer_timeout():
	#$Sprite2D.visible = false
	#$Sprite2D2.visible = true
	if $Sprite2D.visible == true:
		$Sprite2D.visible = false
		$Sprite2D2.visible = true
		#goG()
		$Timer.start()
	if $Sprite2D2.visible == true:
		$Sprite2D2.visible = false
		$Sprite2D3.visible = true
		#goB()
		$Timer.start()
	if $Sprite2D3.visible == true:
		$Sprite2D3.visible = false
		$Sprite2D4.visible = true
		#goP()
		$Timer.start()
	if $Sprite2D4.visible == true:
		$Sprite2D4.visible = false
		$Sprite2D.visible = true
		#goR()
		$Timer.start()
"""
