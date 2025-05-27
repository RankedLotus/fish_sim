extends Node2D

var can_click = true

const koiFish = preload("res://scenes/koi_fish.tscn")

var shader_water_strength : float = 1.0
var menu_target_size : float = 0.2
var menu_size : float = 1.0
var global_attract_position : Vector2 = Vector2.ZERO
@onready var menu = $CanvasLayer/Menu
@export var global_speed = 30

func _ready():
	$AnimationPlayer.play("init_tooltip_fade")
	#$shader.size = DisplayServer.window_get_size()
	menu.scale = Vector2(0, 0)
	#pass
	menu.pivot_offset = DisplayServer.window_get_size() / 2
	#menu.anchor_left = 0.5
	#menu.anchor_top = 0.5
	#menu.anchor_right = 0.5
	#menu.anchor_bottom = 0.5
	#menu.position = Vector2(0, 0)
	#menu.scale = Vector2(0.0, 0.0)

func _update_speeds(multiplier):
	for fish in get_tree().get_nodes_in_group("fishies"):
		fish.mult_speed(multiplier)
	global_speed = multiplier
	
func _update_targets(newpos):
	for fish in get_tree().get_nodes_in_group("fishies"):
		fish._change_target(newpos)
	

func _physics_process(delta):
	#menu.pivot_offset = get_viewport().get_visible_rect().size * 0.5
	
	
	$shader.material.set("shader_parameter/s2", shader_water_strength)
	print($shader.material.get("shader_parameter/s2"))
	
	#var closed = ())
	print(menu.scale)
	if Input.is_action_just_pressed("escape"):
		if menu.scale.x < 0.1:
			$AnimationPlayer.play("zoom_in")
		else:
			$AnimationPlayer.play("zoom_out")
		#menu.visible = not menu.is_visible_in_tree()
		can_click = not can_click
	
	if Input.is_action_just_pressed("rclick") and can_click:
		_update_targets(get_global_mouse_position())
	
	if Input.is_action_just_pressed("click") and can_click:
		_make_fish(get_global_mouse_position())
	


func _make_fish(pos):
	var fish_instance = koiFish.instantiate()
	fish_instance.global_position = pos
	add_child(fish_instance)
	fish_instance.mult_speed(global_speed)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play(0.0)
