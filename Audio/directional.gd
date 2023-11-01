extends Node2D

@onready var midi_player:MidiPlayer = $GodotMIDIPlayer
const SMF = preload( "res://addons/midi/SMF.gd" )
const Utility = preload( "res://addons/midi/Utility.gd" )
var note = preload("res://Rythmn/Notes/note.tscn")

var left = Vector2(0,324);
var right = Vector2(1152,324);
var up = Vector2(576,0); 
var down = Vector2(576,648);
# Called when the node enters the scene tree for the first time.
# func _ready():
# $AudioStreamPlayer2D.play()
func _on_midi_event( channel, event ):
	# channel is same as $GodotMidiPlayer.channel_status[track_id]
	# event is event parameter. see SMF.gd and MidiPlayer.gd
	#     -> more information at "MIDIEvent" at https://bitbucket.org/arlez80/godot-midi-player/wiki/struct/SMF
	var pos = randi() % 4
	var instance = note.instantiate()
	if pos == 0:
		instance.position = left
	if pos == 1:
		instance.position = up
	if pos == 2:
		instance.position = right
	if pos == 3:
		instance.position = down
	add_child(instance)
	print('event',event,channel)
func _ready( ):
	if self.midi_player.connect("midi_event",Callable(self,"_on_midi_event")) != OK:
		print( "error" )
		breakpoint

	# MIDI input test.
	OS.open_midi_inputs( )
	print( OS.get_connected_midi_inputs( ) )
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)
