extends Node2D

@export var dir_vector = Vector2(1, 2) #direction
@export var base_speed = 30
@export var speed = 30
var target_speed = 30
var target_rotation = 0
var curr_rotation = 0
@export var twitch_frequency = Vector2(1, 10) #defines how often behavior generally changes
@export var twitch_strength = Vector2(2, 20) #defines the strength of the change in speed (on natural log curve)
@export var my_timer = 2 #timer on which behavior changes
@export var quadrant_size = Vector2(650, 350)
@export var should_be_flipping = false
var flip_target : Vector2

func get_curr_velocity():
	return dir_vector * speed

func get_position_difference():
	return get_curr_velocity()

func _physics_process(delta):

	#moving values from current to target (to smoothen)
	speed = move_toward(speed, target_speed, randi_range(twitch_frequency.x, twitch_frequency.y))
	if(!should_be_flipping):
		var amt_to_rotate = target_rotation - move_toward(target_rotation, 0, 0.005)
		dir_vector = dir_vector.rotated(amt_to_rotate)
		target_rotation = move_toward(target_rotation, 0, 0.005)
	#rotation = move_toward(rotation, target_rotation, randi_range(twitch_frequency.x, twitch_frequency.y) / 3)
	
	my_timer = max(my_timer - delta, 0)
	
	if my_timer == 0:
		var rsign = sign(randf() - 0.5)
		target_speed = base_speed * log(randi_range(twitch_strength.x, twitch_strength.y))
		target_rotation = rsign * PI / 4 #MAKE IT SO THEY DON'T ALL TURN THE SAME RADIUS
		#dir_vector = dir_vector.rotated(rsign * PI / 4)
		my_timer = randi_range(twitch_frequency.x, twitch_frequency.y)
	
	quadrant_size = get_viewport().get_visible_rect().size / 2
	
	if(should_be_flipping):
		dir_vector.x = move_toward(dir_vector.x, flip_target.x, delta * 6)
		dir_vector.x = move_toward(dir_vector.y, flip_target.y, delta * 6)
	#world border:
	if(global_position.x > quadrant_size.x):
		dir_vector.x = move_toward(dir_vector.x, -2, delta)
	
	if(global_position.x < -quadrant_size.x):
		dir_vector.x = move_toward(dir_vector.x, 2, delta)
	
	if global_position.y > quadrant_size.y:
		dir_vector.y = move_toward(dir_vector.y, -2, delta)
	
	if global_position.y < -quadrant_size.y:
		dir_vector.y = move_toward(dir_vector.y, 2, delta)
