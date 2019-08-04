extends Area2D

export (int) var SPEED = 420
export (PackedScene) var PewPewSoundEffect

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(PewPewSoundEffect.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED * delta

func _on_EnemyProjectile_area_entered(area):
	if area.is_in_group('player'):
		area.take_damage()
		queue_free()
