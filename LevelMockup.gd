extends Node2D

enum { WIN, LOSE, CONTINUE }

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = $Player/StartPosition.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit():
	if $CanvasLayer/PlayerHealthBar.current_health == 0:
		game_over()

func win_game():
	$GUI.show_win_game()
	destroy_player_and_all_enemies()

func game_over():
	$GUI.show_game_over()
	destroy_player_and_all_enemies()

func destroy_player_and_all_enemies():
	$Player.queue_free()
	for enemy in get_tree().get_nodes_in_group('enemies'):
		enemy.queue_free()

func check_win_condition():
	if len(get_tree().get_nodes_in_group('enemies')) == 0:
		return WIN
	else:
		return CONTINUE

func _on_Enemy_hit():
	pass
