extends Area2D
@export var speed = 500.0;
var centerScreen = Vector2(1000,1000)
var current_universe = Global.current_universe

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Note")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move note position towards the center of the screen
	position = position.move_toward(centerScreen, delta * speed)
	if position == centerScreen:
		queue_free()
	
	# Syncs the note sprite with the universe background
	if Global.note_universe == "R":
		$Sprite2D/AnimatedSprite2D.play("realism_emeny_neutral")
		_switch_groups("R","P")
	if Global.note_universe == "B":
		$Sprite2D/AnimatedSprite2D.play("wc_enemy_attack")
		_switch_groups("B","R")
	if Global.note_universe == "G":
		$Sprite2D/AnimatedSprite2D.animation = "Punk_attack"
		_switch_groups("G","B")
	if Global.note_universe == "P":
		$Sprite2D/AnimatedSprite2D.animation = "EDM_attack"
		_switch_groups("P","G")
		
func _on_body_entered(body):
	# if the notes touch the player, and the player is in the correct universe: hit the note
	if body.is_in_group("Player"):
		if self.is_in_group(Global.current_universe) and self.is_in_group("Miss") == false:
				Global.isTouchingNote = true;
				queue_free()
				if self.is_in_group("Perfect"):
					Global.bossHealth -= 2
					
				else:
					Global.bossHealth -= 1
				print("PlayerHit")
				#if Global.note_universe == "R":
					#$Sprite2D/AnimatedSprite2D.play("realism_enemy_death ")
				#if Global.note_universe == "B":
					#$Sprite2D/AnimatedSprite2D.play("wc_enemy_death")
				#if Global.note_universe == "G":
					#$Sprite2D/AnimatedSprite2D.animation = "Punk_death"
				#if Global.note_universe == "P":
					#$Sprite2D/AnimatedSprite2D.animation = "EDM_death"
				
				if Global.bossHealth == 0:
					print("boss dead")
					Global.bossHealth += 100
					get_tree().change_scene_to_file("res://01 Final Draft/Scenes/game_over_screen.tscn")
	
	#if body.is_in_group("DeathBox"):
		#print("DeathBoxHit")
		#Global.missedNotes -= 1
		#if Global.missedNotes == 0:
			#print("dead")
	

# switches notes to be in correct universe
func _switch_groups(NG,OG):
	if self.is_in_group(OG):
		self.remove_from_group(OG)
	if self.is_in_group(NG) == false:
		self.add_to_group(NG)


func _on_area_entered(area):
	if area.is_in_group("Perfect"):
		self.add_to_group("Perfect")
		
	if area.is_in_group("Good"):
		self.remove_from_group("Perfect")
		self.add_to_group("Good")
		
	if area.is_in_group("Miss"):
		self.remove_from_group("Good")
		self.add_to_group("Miss")
		print("Note was missed")
		Global.missedNotes -= 1
		if Global.missedNotes == 0:
			print("dead")
			Global.missedNotes = 50
			get_tree().change_scene_to_file("res://01 Final Draft/Scenes/game_over_screen.tscn")
		queue_free()
