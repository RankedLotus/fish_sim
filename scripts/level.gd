extends Node2D

var can_click = true

const koiFish = preload("res://scenes/koi_fish.tscn")

var shader_water_strength : float = 1.0

func _ready():
	$CanvasLayer/Menu.visible = false

func _physics_process(delta):
	$shader.material.set("shader_parameter/s2", shader_water_strength)
	print($shader.material.get("shader_parameter/s2"))
	
	if Input.is_action_just_pressed("escape"):
		$CanvasLayer/Menu.visible = not $CanvasLayer/Menu.is_visible_in_tree()
		can_click = not can_click
	
	if Input.is_action_just_pressed("click") and can_click:
		_make_fish(get_global_mouse_position())
	


func _make_fish(pos):
	var fish_instance = koiFish.instantiate()
	fish_instance.global_position = pos
	add_child(fish_instance)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play(0.0)
