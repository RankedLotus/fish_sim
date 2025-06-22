extends Control

var is_muted : bool = false
var curr_speed : float = 20.0

func _on_quit_pressed():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	$"../..".shader_water_strength = value


func _on_audio_pressed():
	if not is_muted:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	is_muted = not is_muted


func _on_h_slider_2_value_changed(value):
	var update_mult = value / curr_speed
	curr_speed = value
	$"../.."._update_speeds(value)
	
