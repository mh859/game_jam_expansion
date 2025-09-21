extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@onready var actual_title = $ActualTitle
@onready var back_story = $BackStory


func _on_start_button_pressed():
	actual_title.visible = false
	back_story.visible = true


func _on_lets_go_pressed():
	get_tree().change_scene_to_file("res://game_screen.tscn")

@onready var instructions = $Instructions

func _on_instructions_pressed():
	instructions.visible = true
	actual_title.visible = false
	back_story.visible = false


func _on_button_pressed():
	instructions.visible = false
	actual_title.visible = true
	back_story.visible = false


func _on_back_to_start_pressed():
	instructions.visible = false
	actual_title.visible = true
	back_story.visible = false
