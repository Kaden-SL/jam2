extends Node2D

@onready var narrative_intro = $AnimationPlayer

func _ready():
 narrative_intro.play("Fade In")
 get_tree().create_timer(14).timeout.connect(fade_out)
 

func fade_out():
 narrative_intro.play("Fade Out")
 get_tree().create_timer(4).timeout.connect(start_tutorial)
 

func start_tutorial():
 get_tree().change_scene_to_file("res://01 Final Draft/Tutorial Narrative/tutorial.tscn")
