extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Bbg.visible = false
	$Gbg.visible = false
	$Pbg.visible = false
	$RBG.visible = true
	#bool inR = true
	#bool inG = false
	#bool inB = false
	#bool inP = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("R") && $RBG.visible == false:
		$RBG.visible = true
		$Bbg.visible = false
		$Gbg.visible = false
		$Pbg.visible = false
		#$Player.play("R")
	if Input.is_action_just_pressed("B") && $Bbg.visible == false:
		$Bbg.visible = true
		$Gbg.visible = false
		$RBG.visible = false
		$Pbg.visible = false
		#$Player.play("B")
	if Input.is_action_just_pressed("G") && $Gbg.visible == false:
		$Gbg.visible = true
		$Bbg.visible = false
		$RBG.visible = false
		$Pbg.visible = false
		#$Player.play("G")
	if Input.is_action_just_pressed("P") && $Pbg.visible == false:
		$Pbg.visible = true
		$Bbg.visible = false
		$RBG.visible = false
		$Gbg.visible = false
		#$Player.play("P")
	pass
