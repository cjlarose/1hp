extends Node2D

export (PackedScene) var Title
export (PackedScene) var HowToPlay
export (PackedScene) var Level1
export (PackedScene) var LevelMockup
export (PackedScene) var Level2
export (PackedScene) var SpellyLevel
export (PackedScene) var PoopLevel
export (PackedScene) var LevelMine


var current_scene
var current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
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
	switch_to_scene(get_level_scene(current_level))

func get_level_scene(level_number):
	match level_number:
		1:
			return Level1
		2:
			return LevelMockup
		3:
			return Level2
		4:
			return SpellyLevel
		5:
			return PoopLevel
		6:
			return LevelMine
		7:
			return null

func is_on_final_level():
	return get_level_scene(current_level + 1) == null

func next_level():
	current_level += 1
	switch_to_scene(get_level_scene(current_level))

func replay_level():
	switch_to_scene(get_level_scene(current_level))

func switch_to_scene(scene_type):
	current_scene.queue_free()
	current_scene = scene_type.instance()
	add_child(current_scene)