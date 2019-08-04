extends Node2D

export (PackedScene) var Title
export (PackedScene) var HowToPlay
export (PackedScene) var LevelMockup

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
	switch_to_scene(HowToPlay)

func title():
	switch_to_scene(Title)

func start_game():
	switch_to_scene(LevelMockup)

func switch_to_scene(scene_type):
	current_scene.queue_free()
	current_scene = scene_type.instance()
	add_child(current_scene)