extends KinematicBody2D

export (int) var SPEED = 25
export (int)  var react_time = 200
export (int) var shooting_delay = 2500
export (PackedScene) var EnemyProjectile

onready var player = get_parent().get_node('Player')
var next_dir = Vector2(0,0)
var dir = Vector2(0,0)
var prev_dir_time = 0
var prev_shooting_time = 0

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $HealthBar.current_health != 1:
		handle_shooting()

	var direction_to_player = (player.position - position).normalized()
	set_dir(direction_to_player)

	move_and_collide(dir * delta * SPEED)

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

func set_dir(target_dir):
	next_dir = target_dir
	var current_time = OS.get_ticks_msec()
	if current_time - prev_dir_time > react_time:
       dir = next_dir
       prev_dir_time = current_time

func handle_shooting():
	var current_time = OS.get_ticks_msec()
	if current_time - prev_shooting_time > shooting_delay:
		var projectile = EnemyProjectile.instance()
		projectile.position = position
		projectile.direction = dir.rotated(rand_range(-0.5, 0.5))

		get_parent().add_child(projectile)
		prev_shooting_time = current_time
