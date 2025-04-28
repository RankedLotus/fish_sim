extends Node2D

var has_submerged = false

func _ready():
	self.visible = true
	rotation = randf() * 2 * PI
	$movement.dir_vector = Vector2(cos(rotation), sin(rotation))
	
	$AudioStreamPlayer.play(randf() / 3 + 0.2);

func _physics_process(delta):
	scale.x = move_toward(scale.x, 3, delta)
	scale.y = move_toward(scale.y, 3, delta)
	
	if(scale == Vector2(3, 3) and !has_submerged):
		has_submerged = true
		top_level = false
		$GPUParticles2D.emitting = true
	global_position += $movement.get_position_difference() * delta
	
	rotation = atan2($movement.dir_vector.y, $movement.dir_vector.x) + PI/2
