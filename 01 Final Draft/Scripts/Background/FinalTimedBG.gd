extends StaticBody2D
@export var timeoutTime = 5
var onetime = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Realism.visible = false
	$WaterColor.visible = false
	$Punk.visible = false
	$EDM.visible = false
	#Global.note_universe = Global.current_universe
	#switchU(Global.universe2,false)
	switchBG()

func _process(delta):
	if onetime:
		switchU(Global.universe1,true)
		Global.note_universe = Global.universe1
		onetime = false

# swtiches bg and tells notes to switch sprite
func switchBG():
	await get_tree().create_timer(timeoutTime).timeout
	Global.note_universe = Global.universe2
	switchU(Global.universe2,true)
	switchU(Global.universe1,false)
	await get_tree().create_timer(timeoutTime).timeout
	Global.note_universe = Global.universe1
	switchU(Global.universe1,true)
	switchU(Global.universe2,false)
	switchBG()
	
func switchU(universe,state):
	if universe == "R":
		$Realism.visible = state
	if universe == "G":
		$Punk.visible = state
	if universe == "B":
		$WaterColor.visible = state
	if universe == "P":
		$EDM.visible = state
