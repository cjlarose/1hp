extends Node2D

enum { WIN, LOSE, CONTINUE }
enum GAME_END_REASON { PLAYER_DIED, HOSTAGE_KILLED }

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = $Player/StartPosition.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit():
	if $CanvasLayer/PlayerHealthBar.current_health == 0:
		game_over(GAME_END_REASON.PLAYER_DIED)

func win_game():
	$GUI.show_win_game()
	destroy_player_and_all_enemies()

func game_over(reason):
	if reason == GAME_END_REASON.PLAYER_DIED:
		$GUI.show_try_again_player_died()
	else:
		$GUI.show_try_again_hostage_killed()
	destroy_player_and_all_enemies()

func destroy_player_and_all_enemies():
	$Player.freeze()
	for enemy in get_tree().get_nodes_in_group('enemies'):
		enemy.queue_free()

func check_win_condition():
	if len(get_tree().get_nodes_in_group('enemies')) == 0:
		return WIN
	else:
		return CONTINUE

func _on_Enemy_hit():
	pass

func _on_Enemy_hostage_killed():
	game_over(GAME_END_REASON.HOSTAGE_KILLED)
