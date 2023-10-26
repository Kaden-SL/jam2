extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Bbg.visible = false
	$Gbg.visible = false
	$RBG.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("R") && $RBG.visible == false:
		$RBG.visible = true
		$Bbg.visible = false
		$Gbg.visible = false
	if Input.is_action_just_pressed("B") && $Bbg.visible == false:
		$Bbg.visible = true
		$Gbg.visible = false
		$RBG.visible = false
	if Input.is_action_just_pressed("G") && $Gbg.visible == false:
		$Gbg.visible = true
		$Bbg.visible = false
		$RBG.visible = false
	pass
