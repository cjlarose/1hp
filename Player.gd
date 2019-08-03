extends Area2D

export (int) var SPEED = 200
export (int) var MAX_HEALTH = 100

signal hit

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

func _process(delta):
	var direction = get_input_direction()
	var velocity = direction.normalized()
	
	position += velocity * SPEED

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _on_Player_body_entered(body):
	body.health -= 1
	print(body.health)
	emit_signal('hit')
