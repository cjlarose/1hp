extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_win_game():
	$MessageLabel.text = 'you win'
	$MessageLabel.visible = true
	$PlayAgainButton.show()

func show_game_over():
	$MessageLabel.text = 'you lose'
	$MessageLabel.visible = true
	$PlayAgainButton.show()

func _on_PlayAgainButton_pressed():
	get_parent().get_parent().title()
