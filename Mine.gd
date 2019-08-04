extends StaticBody2D

export (PackedScene) var MineExplodeSoundEffect

var detonated

# Called when the node enters the scene tree for the first time.
func _ready():
	detonated = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func detonate():
	detonated = true
	$AnimatedSprite.animation = 'exploding'
	$AnimatedSprite.play()
	var sound_effect = MineExplodeSoundEffect.instance()
	add_child(sound_effect)


func _on_AnimatedSprite_animation_finished():
	queue_free()
