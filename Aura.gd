extends Area2D

export (PackedScene) var AuraSoundEffect

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(AuraSoundEffect.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
