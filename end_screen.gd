extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass #"You lost all your workes. Not good"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://game_screen.tscn")
