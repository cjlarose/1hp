extends KinematicBody2D

export (PackedScene) var MineExplodeSoundEffect

const EXPLOSION_SIZE = 3

var detonated
var detonated_cycle = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	detonated = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if detonated:
		# ensures that all other objects have a chance to register the detonation
		if detonated_cycle > 0:
			detonated_cycle -= 1
		else:
			# so that enemies aren't instantly killed
			$CollisionPolygon2D.set_scale(Vector2())

func detonate():
	detonated = true
	$AnimatedSprite.animation = 'exploding'
	$AnimatedSprite.set_scale(Vector2(EXPLOSION_SIZE, EXPLOSION_SIZE))
	$CollisionPolygon2D.set_scale(Vector2(EXPLOSION_SIZE, EXPLOSION_SIZE))
	$AnimatedSprite.play()
	var sound_effect = MineExplodeSoundEffect.instance()
	add_child(sound_effect)

func _on_Area2D_body_entered(body):
	print('_on_Area2D_body_entered__mine')
	if 'mines' in body.get_groups() && body.detonated:
		detonate()

func _on_AnimatedSprite_animation_finished():
	queue_free()
