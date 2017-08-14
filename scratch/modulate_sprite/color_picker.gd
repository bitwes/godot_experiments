

func _on_ColorPicker_color_changed( color ):
	get_node("Sprite").set_modulate(color)
	get_node("Mustang").set_modulate(color)
	get_node("Mustang2/Body").set_modulate(color)	
