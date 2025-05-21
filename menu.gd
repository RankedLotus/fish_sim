extends Control


func _on_quit_pressed():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	$"../..".shader_water_strength = value
