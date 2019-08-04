extends Node2D

export (PackedScene) var Title
export (PackedScene) var HowToPlay
export (PackedScene) var LevelMockup
export (PackedScene) var Level2

var current_scene
var current_level

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
	current_level = 1
	switch_to_scene(LevelMockup)

func get_current_level():
	match current_level:
		1:
			return LevelMockup
		2:
			return Level2

func get_next_level():
	match current_level:
		1:
			return Level2
		2:
			return null

func next_level():
	var next_level_scene = get_next_level()
	current_level += 1
	switch_to_scene(next_level_scene)

func replay_level():
	switch_to_scene(get_current_level())

func switch_to_scene(scene_type):
	current_scene.queue_free()
	current_scene = scene_type.instance()
	add_child(current_scene)