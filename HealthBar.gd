extends AnimatedSprite

export var max_health = 10
export var current_health = 10

func _ready():
	_set_hp_frame()

func _set_hp_frame():
	if current_health <= 0:
		set_frame(0)
	elif current_health == 1:
		set_frame(1)
	elif current_health == max_health:
		set_frame(10)
	else:
		var percent = float(current_health) / float(max_health)
		percent = percent * 10
		percent = int(round(percent))
		set_frame(percent)

func update_current_health(health):
	current_health = health
	print(current_health)
	_set_hp_frame()
