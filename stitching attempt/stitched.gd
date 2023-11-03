extends Node2D

@onready var midi_player:MidiPlayer = $GodotMIDIPlayer
const SMF = preload( "res://addons/midi/SMF.gd" )
const Utility = preload( "res://addons/midi/Utility.gd" )
var note = preload("res://Rythmn/Notes/note.tscn")
var counter = 0
var totalCounter = 0
var left = Vector2(0,1000);
var right = Vector2(2000,1000);
var up = Vector2(1000,0); 
var down = Vector2(1000,2000);

func _on_midi_event( channel, event ):
	#print(SMF.MIDIEventType)
	# This chunk of code makes the notes spawn in groups of 3
	if event.type==SMF.MIDIEventType.note_on:
		var instance = note.instantiate()
		if totalCounter == 0:
			instance.position = left
		if totalCounter == 1:
			instance.position = up
		if totalCounter == 2:
			instance.position = right
		if totalCounter == 3:
			instance.position = down
		add_child(instance)
		counter += 1
		if counter == 3:
			counter = 0
			if totalCounter == 3:
				totalCounter = 0
			else:
				totalCounter += 1
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
	
