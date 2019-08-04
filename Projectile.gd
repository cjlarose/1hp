extends Area2D

export (int) var SPEED = 20
export (PackedScene) var PewPewSoundEffect

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	var sound_effect = PewPewSoundEffect.instance()
	add_child(sound_effect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED

func _on_Projectile_body_entered(enemy):
	if 'enemies' in enemy.get_groups():
		enemy.take_damage()
	elif 'mines' in enemy.get_groups():
		enemy.detonate()
	queue_free()
