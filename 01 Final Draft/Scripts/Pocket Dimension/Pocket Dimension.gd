extends StaticBody2D
var onetime = true;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$EDM.visible = false
	$Realism.visible = false
	$WaterColor.visible = false
	$Punk.visible = false
	
func _process(_delta):
	if onetime:
		switchU(Global.universe1,true)
		onetime = false

	if Input.is_action_just_pressed("R") && $Realism.visible == false && isInUniverseList("R"):
		$EDM.visible = false
		$Realism.visible = true
		$WaterColor.visible = false
		$Punk.visible = false
		#$Player.play("R")
	if Input.is_action_just_pressed("B") && $WaterColor.visible == false && isInUniverseList("B"):
		$Realism.visible = false
		$WaterColor.visible = true
		$EDM.visible = false
		$Punk.visible = false
		#$Player.play("B")
	if Input.is_action_just_pressed("G") && $Punk.visible == false && isInUniverseList("G"):
		$WaterColor.visible = false
		$Realism.visible = false
		$EDM.visible = false
		$Punk.visible = true
		#$Player.play("G")
	if Input.is_action_just_pressed("P") && $EDM.visible == false && isInUniverseList("P"):
		$Punk.visible = false
		$Realism.visible = false
		$EDM.visible = true
		$WaterColor.visible = false
		#$Player.play("P")

func isInUniverseList(universe):
	if universe == Global.universe1 or universe == Global.universe2:
		return true
	else:
		return false

func switchU(universe,state):
	if universe == "R":
		$Realism.visible = state
	if universe == "G":
		$Punk.visible = state
	if universe == "B":
		$WaterColor.visible = state
	if universe == "P":
		$EDM.visible = state
