extends Node2D

@onready var midi_player:MidiPlayer = $GodotMIDIPlayer
const SMF = preload( "res://addons/midi/SMF.gd" )
const Utility = preload( "res://addons/midi/Utility.gd" )
var note = preload("res://01 Final Draft/Scenes/Notes/finalnote.tscn")
var left = Vector2(0,1000);
var right = Vector2(2000,1000);
var up = Vector2(1000,0); 
var down = Vector2(1000,2000);
var waiting = true

@export var endOfSong = 0;
@export var secondsForSongToStart = 1.4
@export var continueScene = false
@export var continuedScene = false

@export var universe1 = ""
@export var universe2 = ""

func _on_midi_event( channel, event ):
	#print(SMF.MIDIEventType)
	# This chunk of code makes the notes spawn in groups of 3
	if event.type==SMF.MIDIEventType.note_on:
		var instance = note.instantiate()
		var dir = _RandomNumber(100)
		if dir % 4 == 0:
			instance.position = left
		elif dir % 4 != 0 && dir % 2 == 0:
			instance.position = up
		elif dir % 4 != 0 && dir % 2 != 0 && dir % 6 == 0:
			instance.position = right
		elif dir % 4 != 0 && dir % 2 != 0 && dir % 6 != 0 && dir % 3 == 0:
			instance.position = down
		else:
			dir = _RandomNumber(4)
			if dir == 0:
				instance.position = left
			if dir == 1:
				instance.position = up
			if dir == 2:
				instance.position = right
			if dir == 3:
				instance.position = down
		add_child(instance)

func _ready( ):
	# Pick two universes to be used
	Global.universe1 = universe1
	Global.universe2 = universe2
	Global.current_universe = Global.universe1

	if self.midi_player.connect("midi_event",Callable(self,"_on_midi_event")) != OK:
		print( "error" )
		breakpoint
	# MIDI input test.
	if continuedScene:
		if Global.prevBossHealth == 0 or Global.prevMissedNotes == 0:
			Global.bossHealth = Global.deafultbossHealth
			Global.missedNotes = Global.defaultmissedNotes
		else:
			Global.bossHealth = Global.prevBossHealth
			Global.missedNotes = Global.prevMissedNotes
	else:
		Global.bossHealth = Global.deafultbossHealth
		Global.missedNotes = Global.defaultmissedNotes
	OS.open_midi_inputs( )
	print( OS.get_connected_midi_inputs( ) )
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)
	await tryAwait()


	
func _process(delta):
	_CheckEnd($UniversePlayer1)
	_CheckEnd($UniversePlayer2)
	if Global.current_universe == "R" && !waiting:
		if Global.current_universe == Global.universe1:
			_SwitchAudioPlayer($UniversePlayer1,$UniversePlayer2)
			_CheckEnd($UniversePlayer1)
		elif Global.current_universe == Global.universe2:
			_SwitchAudioPlayer($UniversePlayer2,$UniversePlayer1)
			_CheckEnd($UniversePlayer2)
	
	if Global.current_universe == "G":
		if Global.current_universe == Global.universe1:
			_SwitchAudioPlayer($UniversePlayer1,$UniversePlayer2)
			_CheckEnd($UniversePlayer1)
		elif Global.current_universe == Global.universe2:
			_SwitchAudioPlayer($UniversePlayer2,$UniversePlayer1)
			_CheckEnd($UniversePlayer2)
	
	if Global.current_universe == "B":
		if Global.current_universe == Global.universe1:
			_SwitchAudioPlayer($UniversePlayer1,$UniversePlayer2)
			_CheckEnd($UniversePlayer1)
		elif Global.current_universe == Global.universe2:
			_SwitchAudioPlayer($UniversePlayer2,$UniversePlayer1)
			_CheckEnd($UniversePlayer2)
	
	if Global.current_universe == "P":
		if Global.current_universe == Global.universe1:
			_SwitchAudioPlayer($UniversePlayer1,$UniversePlayer2)
			_CheckEnd($UniversePlayer1)
		elif Global.current_universe == Global.universe2:
			_SwitchAudioPlayer($UniversePlayer2,$UniversePlayer1)
			_CheckEnd($UniversePlayer2)
	
	get_node("/root/Final Draft/PlayerHealthBar").set_value(Global.missedNotes)
	get_node("/root/Final Draft/BossHealthBar").set_value(Global.bossHealth)
	
func _CheckEnd(AudioPlayer):
	if AudioPlayer.get_playback_position() >= endOfSong:
		if continueScene:
			Global.prevBossHealth = Global.bossHealth
			Global.prevMissedNotes = Global.missedNotes
		Global.currentLevel += 1
		if Global.currentLevel != 4:
			get_tree().change_scene_to_file("res://01 Final Draft/Scenes/01-Main/Final Draft"+str(Global.currentLevel)+".tscn")
		else:
			get_tree().change_scene_to_file("res://01 Final Draft/Scenes/game_over_screen.tscn")
	else:
		#print(AudioPlayer.get_playback_position())
		pass

func _SwitchAudioPlayer(NP,OP1):
	if NP.has_stream_playback() == false:
		NP.play()
		if OP1.has_stream_playback():
			NP.seek(OP1.get_playback_position())
			OP1.stop()
			
func _RandomNumber(maxnum):
	return randi() % maxnum
	
func tryAwait():
	await get_tree().create_timer(secondsForSongToStart).timeout
	$UniversePlayer1.play()
	$UniversePlayer2.stop()
	waiting = false
