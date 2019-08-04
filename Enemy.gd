extends KinematicBody2D

export (int) var SPEED = 25
export (int)  var react_time = 200
export (int) var shooting_delay = 5
export (PackedScene) var EnemyProjectile

onready var player = get_parent().get_node('Player')
var next_dir = Vector2(0,0)
var dir = Vector2(0,0)
var prev_dir_time = 0
var rng = RandomNumberGenerator.new()
var shooting_timer = Timer.new()

var collision_react_time = 1500
var collision = false
var collision_multiplier = 1

var last_delta

signal hit
signal hostage_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	shooting_timer.connect("timeout",self,"_on_shooting_timer_timeout")
	add_child(shooting_timer)
	shooting_timer.start(rng.randf_range(2, shooting_delay))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	last_delta = delta
	var direction_to_player = (player.position - position).normalized()
	set_dir(direction_to_player)

	move_and_collide(dir * delta * SPEED * collision_multiplier)

func take_damage():
	$AnimatedSprite.set_frame(1)
	$AnimatedSprite.play()
	$HealthBar.update_current_health($HealthBar.current_health - 1)
	match $HealthBar.current_health:
		0:
			# TODO: blow up or something
			emit_signal('hostage_killed')
			$AnimatedSprite.animation = 'default'
		1:
			$AnimatedSprite.animation = '1hp'
			$CollisionShape2D.set_scale(Vector2(0.9, 0.5))
		_:
			$AnimatedSprite.animation = 'default'

	emit_signal('hit')

func set_dir(target_dir):
	next_dir = target_dir
	var current_time = OS.get_ticks_msec()
	if (!collision && current_time - prev_dir_time > react_time):
		dir = next_dir
		prev_dir_time = current_time
	if (collision && current_time - prev_dir_time > collision_react_time):
		dir = next_dir
		prev_dir_time = current_time
		collision = false
		collision_multiplier = 1
		collision_react_time = 1500

func handle_shooting():
	var projectile = EnemyProjectile.instance()
	projectile.position = position
	projectile.direction = dir.rotated(rand_range(-0.5, 0.5))

	get_parent().add_child(projectile)

func handle_collision_with_player(motion):
	dir = motion
	collision_multiplier = motion.length() * 3
	collision_react_time *= motion.length()
	collision = true
	$AnimatedSprite.set_frame(1)
	$AnimatedSprite.play()

func _on_shooting_timer_timeout():
	if $HealthBar.current_health != 1:
		handle_shooting()
		shooting_timer.start(rng.randf_range(2,shooting_delay))