extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Realism.visible = true
	$WaterColor.visible = false
	$Punk.visible = false
	$EDM.visible = false
	#bool inR = true
	#bool inG = false
	#bool inB = false
	#bool inP = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("R") && $Realism.visible == false && Global.sceneTiming == false:
		$EDM.visible = false
		$Realism.visible = true
		$WaterColor.visible = false
		$Punk.visible = false
		#$Player.play("R")
	if Input.is_action_just_pressed("B") && $WaterColor.visible == false && Global.isHalfwayThroughSong == true && Global.sceneTiming == true:
		$Realism.visible = false
		$WaterColor.visible = true
		$EDM.visible = false
		$Punk.visible = false
		#$Player.play("B")
	if Input.is_action_just_pressed("G") && $Punk.visible == false && Global.sceneTiming == false:
		$WaterColor.visible = false
		$Realism.visible = false
		$EDM.visible = false
		$Punk.visible = true
		#$Player.play("G")
	if Input.is_action_just_pressed("P") && $EDM.visible == false && Global.isHalfwayThroughSong == true && Global.sceneTiming == true:
		$Punk.visible = false
		$Realism.visible = false
		$EDM.visible = true
		$WaterColor.visible = false
		#$Player.play("P")
	pass
