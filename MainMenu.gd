extends Node2D

export (PackedScene) var Title
export (PackedScene) var HowToPlay

var current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	current_scene = Title.instance()
	add_child(current_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func how_to_play():
	current_scene.queue_free()
	current_scene = HowToPlay.instance()
	add_child(current_scene)

func title():
	current_scene.queue_free()
	current_scene = Title.instance()
	add_child(current_scene)
