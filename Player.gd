extends Area2D

export (PackedScene) var Projectile

export (int) var SPEED = 500
export (int) var MAX_HEALTH = 30
export (int) var TRACTOR_RANGE = 200

signal hit

var health
var face_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	health = MAX_HEALTH
	face_direction = Vector2(0, 1)

func _process(delta):
	handle_movement(delta)
	handle_shooting()
	handle_rescuing()

func handle_movement(delta):
	var direction = get_input_direction().normalized()

	# If the Player moved, update their face_direction, otherwise maintain it
	if direction != Vector2(0, 0):
		face_direction = direction

	var target_position = position + direction * SPEED * delta
	if target_position.x > 100 and target_position.x < 1100 and \
	   target_position.y > 100 and target_position.y < 700:
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
		if enemy and enemy.health == 1:
			print('neutralized enemy!')
			if len(get_tree().get_nodes_in_group('enemies')) == 1:
				get_parent().win_game()
			enemy.queue_free()

func get_enemy_in_range():
	for enemy in get_tree().get_nodes_in_group('enemies'):
		if position.distance_to(enemy.position) < TRACTOR_RANGE:
			return enemy

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _on_Player_body_entered(body):
	print('_on_Player_body_entered')
	health -= 10
	emit_signal('hit')

