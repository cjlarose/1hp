extends Area2D

export (PackedScene) var AuraSoundEffect
var curr_length = 0
var reached = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(AuraSoundEffect.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (get_parent().currently_rescuing):
		update()

func _draw():
	var vec = to_local(get_parent().currently_rescuing.position)
	curr_length += 10
	if (!reached && curr_length > vec.length()):
		curr_length = vec.length();
		reached = true
	elif (reached):
		curr_length = vec.length();
	var to = vec.normalized() * curr_length
	draw_line(
		Vector2(0, 0), 
		to, 
		Color( 0.5, 1, 0.83, 1 ), 
		10)
	draw_line(
		Vector2(0, 0), 
		to, 
		Color( 1, 1, 1, 1 ), 
		3)
