extends Area2D

export (PackedScene) var Projectile

export (int) var SPEED = 500
export (int) var TRACTOR_RANGE = 200
const TURN_SPEED = 180
const MOVE_SPEED = 220
const ACC = 0.1
const DEC = 0.0075

var motion = Vector2(0,0)

signal hit

var face_direction
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	face_direction = Vector2(0, 1)
	$HealthBar.max_health = 4
	$HealthBar.current_health = 4

func _process(delta):
	handle_movement(delta)
	handle_shooting()
	handle_rescuing()

func handle_movement(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += TURN_SPEED * delta
		
	face_direction = Vector2(1,0).rotated(rotation)
	
	if Input.is_action_pressed("ui_up"):
		motion = motion.linear_interpolate(face_direction, ACC)
		if $AnimatedSprite.animation == 'default':
			$AnimatedSprite.play('Thrust')
	else:
		motion = motion.linear_interpolate(Vector2(0,0), DEC)
		if $AnimatedSprite.animation == 'Thrust':
			$AnimatedSprite.set_animation('default')
	
	var target_position = position + motion * MOVE_SPEED * delta
	if target_position.x > 100 and target_position.x < 1700 and \
	   target_position.y > 100 and target_position.y < 1100:
		position = target_position

func handle_shooting():
	if Input.is_action_just_pressed('ui_accept'):
		var projectile = Projectile.instance()
		projectile.position = position
		projectile.direction = face_direction
		get_parent().add_child(projectile)

func handle_rescuing():
	if Input.is_action_just_pressed('rescue'):
		var enemy = get_enemy_in_range()
		if enemy and enemy.get_node('HealthBar').current_health == 1:
			print('neutralized enemy!')
			if len(get_tree().get_nodes_in_group('enemies')) == 1:
				get_parent().win_game()
			enemy.queue_free()

func get_enemy_in_range():
	for enemy in get_tree().get_nodes_in_group('enemies'):
		if position.distance_to(enemy.position) < TRACTOR_RANGE:
			return enemy

func _on_Player_body_entered(body):
	print('_on_Player_body_entered')
	if 'mines' in body.get_groups():
		body.detonate()

	$HealthBar.update_current_health($HealthBar.current_health - 1)
	emit_signal('hit')

func _on_Player_area_entered(body):
	pass
