extends Node2D

enum { WIN, LOSE, CONTINUE }

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit():
	$GUI/PlayerHealth.text = str($Player.health)

	if $Player.health == 0:
		game_over()

func win_game():
	$GUI/WinText.text = 'you win'
	$GUI/WinText.visible = true

func game_over():
	$GUI/WinText.text = 'you lose'
	$GUI/WinText.visible = true

func check_win_condition():
	var won = true
	for child in get_tree().get_nodes_in_group('enemies'):
		if child.health <= 0:
			return LOSE
		elif child.health != 1:
			won = false

	if won:
		return WIN
	else:
		return CONTINUE

func _on_Enemy_hit():
	match check_win_condition():
		WIN:
			win_game()
		LOSE:
			game_over()

