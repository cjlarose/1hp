extends Area2D

export (PackedScene) var Projectile

export (int) var SPEED = 200
export (int) var MAX_HEALTH = 100

signal hit

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	health = MAX_HEALTH

func _process(delta):
	handle_movement()
	handle_shooting()

func handle_movement():
	var direction = get_input_direction()
	var velocity = direction.normalized()
	position += velocity * SPEED

func handle_shooting():
	if Input.is_action_just_pressed('ui_accept'):
		print('fire')
		var projectile = Projectile.instance()
		projectile.position = Vector2(rand_range(0, 100), rand_range(0, 100))
		get_parent().add_child(projectile)

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _on_Player_body_entered(body):
	if 'enemies' in body.get_groups():
		body.health -= 1
		print(body.health)
		emit_signal('hit')
