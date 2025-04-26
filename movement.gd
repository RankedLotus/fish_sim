extends Node2D

@export var dir_vector = Vector2(1, 2) #direction
@export var base_speed = 20
@export var speed = 20
@export var twitch_frequency = Vector2(1, 10) #defines how often behavior generally changes
@export var twitch_strength = Vector2(2, 20) #defines the strength of the change in speed (on natural log curve)
@export var my_timer = 2 #timer on which behavior changes

func get_curr_velocity():
	return dir_vector * speed

func get_position_difference():
	return get_curr_velocity()

func _physics_process(delta):
	my_timer = max(my_timer - delta, 0)
	
	if my_timer == 0:
		var rsign = sign(randf() - 0.5)
		speed = base_speed * log(randi_range(twitch_strength.x, twitch_strength.y))
		dir_vector = dir_vector.rotated(rsign * PI / 4)
		my_timer = randi_range(twitch_frequency.x, twitch_frequency.y)
