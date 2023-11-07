extends Node2D

@onready var midi_player:MidiPlayer = $GodotMIDIPlayer
const SMF = preload( "res://addons/midi/SMF.gd" )
const Utility = preload( "res://addons/midi/Utility.gd" )
var note = preload("res://01 Final Draft/Scenes/Notes/finalnote.tscn")
var left = Vector2(0,1000);
var right = Vector2(2000,1000);
var up = Vector2(1000,0); 
var down = Vector2(1000,2000);
@export var halfwayThroughSong = 0;

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
	if self.midi_player.connect("midi_event",Callable(self,"_on_midi_event")) != OK:
		print( "error" )
		breakpoint
	# MIDI input test.
	OS.open_midi_inputs( )
	print( OS.get_connected_midi_inputs( ) )
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)
	await get_tree().create_timer(1.4).timeout
	$TheMusicPlayer.play()
	$MusicPlayerRock.stop()
	$MusicPlayerMelodic.stop()
	$MusicPlayerEDM.stop()
	
func _process(delta):
	if Global.current_universe == "R":
		_SwitchAudioPlayer($TheMusicPlayer,$MusicPlayerRock,$MusicPlayerMelodic,$MusicPlayerEDM)
		_CheckHalfTime($TheMusicPlayer)
	
	if Global.current_universe == "G":
		_SwitchAudioPlayer($MusicPlayerRock,$TheMusicPlayer,$MusicPlayerMelodic,$MusicPlayerEDM)
		_CheckHalfTime($MusicPlayerRock)
	
	if Global.current_universe == "B":
		_SwitchAudioPlayer($MusicPlayerMelodic,$MusicPlayerEDM,$MusicPlayerRock,$TheMusicPlayer)
	if Global.current_universe == "P":
		_SwitchAudioPlayer($MusicPlayerEDM,$MusicPlayerMelodic,$MusicPlayerRock,$TheMusicPlayer)
		
	$PlayerHealthBar.set_value(Global.missedNotes)
	$BossHealthBar.set_value(Global.bossHealth)
	#get_node("/root/Final Draft/PlayerHealthBar").set_value(Global.missedNotes)
	#get_node("$PlayerHealthBarBossHealthBar").set_value(Global.bossHealth)

func _CheckHalfTime(AudioPlayer):
	if AudioPlayer.get_playback_position() >= halfwayThroughSong:
		Global.isHalfwayThroughSong = true;
	# print(AudioPlayer.get_playback_position())
func _SwitchAudioPlayer(NP,OP1,OP2,OP3):
	if NP.has_stream_playback() == false:
		NP.play()
		if OP1.has_stream_playback():
			NP.seek(OP1.get_playback_position())
			OP1.stop()
		if OP2.has_stream_playback():
			NP.seek(OP2.get_playback_position())
			OP2.stop()
		if OP3.has_stream_playback():
			NP.seek(OP3.get_playback_position())
			OP3.stop()
			
func _RandomNumber(maxnum):
	return randi() % maxnum
