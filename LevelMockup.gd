extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit():
#	$GUI/PlayerHealth.text = str($Player.health)
	if check_win_condition():
		$GUI/WinText.visible = true

func check_win_condition():
	for child in get_tree().get_nodes_in_group('enemies'):
		if child.health != 1:
			return false

	return true
