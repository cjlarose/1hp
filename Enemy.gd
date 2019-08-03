extends KinematicBody2D

export (int) var SPEED = 25

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().get_node('Player')
	var direction_to_player = (player.position - position).normalized()
	move_and_collide(direction_to_player * delta * SPEED)

func take_damage():
	$HealthBar.update_current_health($HealthBar.current_health - 1)
	match $HealthBar.current_health:
		0:
			# TODO: blow up or something
			get_parent().game_over()
			$AnimatedSprite.animation = 'default'
		1:
			$AnimatedSprite.animation = '1hp'
		_:
			$AnimatedSprite.animation = 'default'

	emit_signal('hit')
