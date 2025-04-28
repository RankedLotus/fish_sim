extends Node2D

const koiFish = preload("res://basic_bird.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		_make_fish(get_global_mouse_position())


func _make_fish(pos):
	var fish_instance = koiFish.instantiate()
	fish_instance.global_position = pos
	add_child(fish_instance)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play(0.0)
