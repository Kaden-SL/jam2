extends Node2D

@onready var tutorial_intro = $AnimationPlayer

func _ready():
 tutorial_intro.play("Fade In")
 get_tree().create_timer(22).timeout.connect(fade_out)
 

func fade_out():
 tutorial_intro.play("Fade Out")
 get_tree().create_timer(4).timeout.connect(start_game)
 

func start_game():
 get_tree().change_scene_to_file("res://01 Final Draft/Scenes/01-Main/Final Draft0.tscn")
