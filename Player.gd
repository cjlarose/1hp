extends Area2D

export (PackedScene) var Projectile
export (PackedScene) var Aura
export (PackedScene) var ThunkSoundEffect
export (PackedScene) var FanfareSoundEffect

export (int) var TRACTOR_RANGE = 250
const TURN_SPEED = 180
const MOVE_SPEED = 220
const ACC = 0.1
const DEC = 0.0075
const COLLISION_BOUNCE = 0.7

var motion = Vector2(0,0)

signal hit

var face_direction
var currently_rescuing
var health_bar
var frozen

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	face_direction = Vector2(0, 1)
	health_bar = get_parent().get_node('CanvasLayer/PlayerHealthBar')
	health_bar.max_health = 4
	health_bar.current_health = 4
	currently_rescuing = null
	frozen = false

func _process(delta):
	if frozen == false:
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
			$ThrusterSoundEffect.play()
	else:
		motion = motion.linear_interpolate(Vector2(0,0), DEC)
		if $AnimatedSprite.animation == 'Thrust':
			$AnimatedSprite.set_animation('default')
			$ThrusterSoundEffect.stop()
	
	var target_position = position + motion * MOVE_SPEED * delta
	if target_position.x > 100 and target_position.x < 1700:
		position.x = target_position.x
	if target_position.y > 100 and target_position.y < 1100:
		position.y = target_position.y

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
			currently_rescuing = enemy
			$RescueTimer.start()
			var aura = Aura.instance()
			add_child(aura)
	elif Input.is_action_pressed('rescue'):
		if currently_rescuing:
			# Player/Enemy moved out of range
			if position.distance_to(currently_rescuing.position) > TRACTOR_RANGE:
				stop_aura()
	elif currently_rescuing:
		# No longer pressing Shift
		stop_aura()

func stop_aura():
	currently_rescuing = null
	$RescueTimer.stop()
	get_node('Aura').queue_free()

func get_enemy_in_range():
	for enemy in get_tree().get_nodes_in_group('enemies'):
		if position.distance_to(enemy.position) <= TRACTOR_RANGE:
			return enemy

func _on_Player_body_entered(body):
	print('_on_Player_body_entered')
	if 'mines' in body.get_groups():
		body.detonate()

	take_damage()

	if 'enemies' in body.get_groups():
		var dir = body.dir
		body.handle_collision_with_player(motion)

		if motion.length() < (body.SPEED * body.last_delta):
			motion = dir * (body.SPEED * body.last_delta)
		else :
			motion = -motion * COLLISION_BOUNCE
	
func take_damage():
	add_child(ThunkSoundEffect.instance())
	health_bar.update_current_health(health_bar.current_health - 1)
	emit_signal('hit')

func freeze():
	hide()
	frozen = true
	$ThrusterSoundEffect.stop()

func unfreeze():
	show()
	frozen = false

func explode():
	$AnimatedSprite.animation = 'exploding'
	$AnimatedSprite.play()
	yield($AnimatedSprite, 'animation_finished')
	freeze()

func _on_RescueTimer_timeout():
	add_child(FanfareSoundEffect.instance())
	if currently_rescuing:
		if len(get_tree().get_nodes_in_group('enemies')) == 1:
			get_parent().win_game()
		currently_rescuing.queue_free()
		stop_aura()
