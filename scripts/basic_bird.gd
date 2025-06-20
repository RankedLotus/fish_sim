extends Node2D

var has_submerged = false
var has_flipped = false
@onready var rclick_dir : Vector2 = $movement.dir_vector
var moving_toward_rclick : bool = false

func _change_target(newpos):
	var new_vec = (newpos - global_position).normalized() * 2
	var amt_to_rotate = $movement.dir_vector.angle_to(new_vec)
	rclick_dir = new_vec
	moving_toward_rclick = true
	#$movement.target_rotation += amt_to_rotate
	#$movement.target_speed *= 1.8
	

func mult_speed(mult):
	$movement.base_speed = mult
	$movement.speed = mult
	$movement.target_speed = mult


func _ready():
	self.add_to_group("fishies")
	
	var which_sprite = randi_range(0, 50)
	
	#$Sprite2D.frame = which_sprite % 6
	if which_sprite < 15:
		$Sprite2D.frame = 0
	elif which_sprite < 30:
		$Sprite2D.frame = 1
	elif which_sprite < 35:
		$Sprite2D.frame = 2
	elif which_sprite < 40:
		$Sprite2D.frame = 3
	elif which_sprite < 45:
		$Sprite2D.frame = 4
	else:
		$Sprite2D.frame = 5
	
	self.visible = true
	rotation = randf() * 2 * PI
	$movement.dir_vector = Vector2(cos(rotation), sin(rotation))
	
	$AudioStreamPlayer.play(randf() / 3 + 0.2);

func _physics_process(delta):
	
	if moving_toward_rclick:
		$movement.dir_vector = $movement.dir_vector.move_toward(rclick_dir, delta)
		
		if $movement.dir_vector == rclick_dir:
			moving_toward_rclick = false
	
	
	scale.x = move_toward(scale.x, 3, delta * 4)
	scale.y = move_toward(scale.y, 3, delta * 4)
	
	if(scale == Vector2(3, 3) and !has_submerged):
		has_submerged = true
		top_level = false
		$GPUParticles2D.emitting = true
	global_position += $movement.get_position_difference() * delta
	
	rotation = atan2($movement.dir_vector.y, $movement.dir_vector.x) + PI/2


func _on_area_2d_area_entered(area):
	if(!has_flipped):
		#$movement.speed += 90
		#$movement.should_be_flipping = true
		#$movement.flip_target = $movement.dir_vector * -1
		$movement.target_rotation += PI/3
		has_flipped = true
		$sprint_timer.start()
		
func _on_sprint_timer_timeout():
	$movement.should_be_flipping = false
	has_flipped = false
