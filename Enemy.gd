extends RigidBody2D

signal hit

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_damage():
	health -= 1
	emit_signal('hit')
