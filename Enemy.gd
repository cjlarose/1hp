extends KinematicBody2D

export (int) var SPEED = 25

signal hit

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().get_node('Player')
	var direction_to_player = (player.position - position).normalized()
	move_and_collide(direction_to_player * delta * SPEED)
#	position += direction_to_player * SPEED * delta

func take_damage():
	health -= 1
	match health:
		0:
			# TODO: blow up or something
			$AnimatedSprite.animation = 'default'
		1:
			$AnimatedSprite.animation = 'neutralized'
		_:
			$AnimatedSprite.animation = 'default'

	emit_signal('hit')
