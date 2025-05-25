extends Node2D

var can_click = true

const koiFish = preload("res://scenes/koi_fish.tscn")

var shader_water_strength : float = 1.0
var menu_target_size : float = 0.2
var menu_size : float = 1.0
@onready var menu = $CanvasLayer/Menu
func _ready():
	menu.scale = Vector2(0.0, 0.0)

func _physics_process(delta):
	$shader.material.set("shader_parameter/s2", shader_water_strength)
	print($shader.material.get("shader_parameter/s2"))
	
	#var closed = ())
	print(menu.scale)
	if Input.is_action_just_pressed("escape"):
		if menu.scale.x < 0.1:
			$AnimationPlayer.play("zoom_in")
		if menu.scale == Vector2(1.0, 1.0):
			$AnimationPlayer.play("zoom_out")
		#menu.visible = not menu.is_visible_in_tree()
		can_click = not can_click
		
	
	if Input.is_action_just_pressed("click") and can_click:
		_make_fish(get_global_mouse_position())
	


func _make_fish(pos):
	var fish_instance = koiFish.instantiate()
	fish_instance.global_position = pos
	add_child(fish_instance)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play(0.0)
