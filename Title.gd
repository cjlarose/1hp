extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_position(Vector2(0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		start_game()

func _on_StartButton_pressed():
	start_game()

func start_game():
	get_parent().start_game()

func _on_HowToPlayLink_pressed():
	get_parent().how_to_play()
