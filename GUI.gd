extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_win_game():
	$MessageLabel.text = 'you win'
	$MessageLabel.show()
	$PlayAgainButton.show()

func show_try_again():
	$MessageLabel.text = 'try again?'
	$MessageLabel.show()
	$PlayAgainButton.show()

func _on_PlayAgainButton_pressed():
	get_parent().get_parent().title()
