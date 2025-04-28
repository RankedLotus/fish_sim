extends Node2D

func _ready():
	self.visible = true
	rotation = randf() * 2 * PI
	$movement.dir_vector = Vector2(cos(rotation), sin(rotation))
	$GPUParticles2D.emitting = true;
	$AudioStreamPlayer.play(randf() / 3 + 0.4);

func _physics_process(delta):
	global_position += $movement.get_position_difference() * delta
	
	rotation = atan2($movement.dir_vector.y, $movement.dir_vector.x) + PI/2
