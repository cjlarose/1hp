extends Area2D

export (int) var SPEED = 20

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED

func _on_Projectile_body_entered(enemy):
	enemy.take_damage()
	queue_free()
