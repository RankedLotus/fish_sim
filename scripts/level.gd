extends Node2D

var can_click : bool = true

const koiFish = preload("res://scenes/koi_fish.tscn")

var shader_water_strength : float = 1.0
var menu_target_size : float = 0.2
var menu_size : float = 1.0
var global_attract_position : Vector2 = Vector2.ZERO
var pulse_timer : float = 10
@onready var bkgs = [$floor1, $floor2, $floor3, $floor4, $floor5]
var which_bkg : int = 1
@onready var menu = $CanvasLayer/Menu
@export var global_speed : int = 30

func _ready():
	which_bkg = randi_range(0, 3);
	bkgs[which_bkg].show()
	$tooltipAnimation.play("init_tooltip_fade")
	#$shader.size = DisplayServer.window_get_size()
	menu.scale = Vector2(0, 0)
	#pass
	menu.pivot_offset = DisplayServer.window_get_size() / 2


func _update_speeds(multiplier):
	for fish in get_tree().get_nodes_in_group("fishies"):
		fish.mult_speed(multiplier)
	global_speed = multiplier
	
func _update_targets(newpos):
	for fish in get_tree().get_nodes_in_group("fishies"):
		fish._change_target(newpos)
	

func _physics_process(delta):
	if pulse_timer < 10:
		pulse_timer += delta * 0.4
		$CanvasLayer/ripple_shader.material.set_shader_parameter("size", pulse_timer)
		$CanvasLayer/ColorRect.material.set_shader_parameter("size", pulse_timer)
	#menu.pivot_offset = get_viewport().get_visible_rect().size * 0.5
	
	
	$shader.material.set("shader_parameter/s2", shader_water_strength)
	#print($shader.material.get("shader_parameter/s2"))
	
	#var closed = ())
	#print(menu.scale)
	if Input.is_action_just_pressed("escape"):
		if menu.scale.x < 0.1:
			$AnimationPlayer.play("zoom_in")
		else:
			$AnimationPlayer.play("zoom_out")
		#menu.visible = not menu.is_visible_in_tree()
		can_click = not can_click

	if Input.is_action_just_pressed("switch"):
		bkgs[which_bkg % bkgs.size()].hide()
		which_bkg = which_bkg + 1
		bkgs[which_bkg % bkgs.size()].show()
	
	if Input.is_action_just_pressed("rclick") and can_click:
		_update_targets(get_global_mouse_position())
		
		$GPUParticles2D.position = get_global_mouse_position()
		$GPUParticles2D.emitting = true
		#updating distortion center:
		#pulse_timer = 0
		
		#var screen_size : Vector2 = $CanvasLayer/Camera2D.get_window().size
		#var new_center = get_global_mouse_position().normalized()
		#Vector2((get_global_mouse_position().x + (screen_size.x / 2)) / screen_size.x,
		#(get_global_mouse_position().y + (screen_size.y / 2)) / screen_size.y)#/ $Camera2D.get_window() #(get_global_mouse_position() + (get_viewport().get_visible_rect().size / 2)) / Vector2(get_viewport().get_visible_rect().size) * Vector2(0.5, 1)
		
		
		#var new_center = ((get_global_mouse_position() / 2940) / 2) + Vector2(0.5, 0.5)
		#new_center = Vector2.ZERO
		#var new_center = (get_global_mouse_position() / 100 / 2) + Vector2(0.5, 0.5)
		#new_center = Vector2.ZERO
		#print("Mouse pos: ")
		#print(get_global_mouse_position())
		#print(new_center)
		#print($Camera2D.get_window().size)
		#print(get_global_mouse_position())
		#print(get_global_mouse_position().x + (screen_size.x / 2))
		#print(new_center)
		
		#$CanvasLayer/Sprite2D.material.set_shader_parameter("center", new_center)
		#$CanvasLayer/ColorRect.material.set_shader_parameter("center", new_center)
		#$CanvasLayer/ripple_shader.material.set_shader_parameter("center", new_center)
	
	if Input.is_action_just_pressed("click") and can_click:
		_make_fish(get_global_mouse_position())
	


func _make_fish(pos):
	var fish_instance = koiFish.instantiate()
	fish_instance.global_position = pos
	add_child(fish_instance)
	fish_instance.mult_speed(global_speed)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play(0.0)
