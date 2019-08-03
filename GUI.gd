extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_win_game():
	$WinText.text = 'you win'
	$WinText.visible = true

func show_game_over():
	$WinText.text = 'you lose'
	$WinText.visible = true