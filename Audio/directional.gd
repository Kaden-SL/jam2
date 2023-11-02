extends Node2D

@onready var midi_player:MidiPlayer = $GodotMIDIPlayer
const SMF = preload( "res://addons/midi/SMF.gd" )
const Utility = preload( "res://addons/midi/Utility.gd" )
var note = preload("res://Rythmn/Notes/note.tscn")

var left = Vector2(0,1000);
var right = Vector2(2000,1000);
var up = Vector2(1000,0); 
var down = Vector2(1000,2000);
# Called when the node enters the scene tree for the first time.
# func _ready():
# $AudioStreamPlayer2D.play()
func _on_midi_event( channel, event ):
	# channel is same as $GodotMidiPlayer.channel_status[track_id]
	# event is event parameter. see SMF.gd and MidiPlayer.gd
	#     -> more information at "MIDIEvent" at https://bitbucket.org/arlez80/godot-midi-player/wiki/struct/SMF
	var instance = note.instantiate()
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
