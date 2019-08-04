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
	$NextLevelButton.show()

func show_try_again_player_died():
	$MessageLabel.text = 'you died'
	$MessageLabel.show()
	$TryAgainButton.show()

func show_try_again_hostage_killed():
	$MessageLabel.text = 'you killed a hostage'
	$MessageLabel.show()
	$TryAgainButton.show()

func _on_TryAgainButton_pressed():
	get_parent().get_parent().start_game()

func _on_NextLevelButton_pressed():
	get_parent().get_parent().next_level()
