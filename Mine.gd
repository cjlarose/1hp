extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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

func _on_AnimatedSprite_animation_finished():
	queue_free()
