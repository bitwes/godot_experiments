
func _on_CheckScale_toggled( pressed ):
	var b = get_node("CanvasLayer/ScaleButton")
	if(pressed):
		b.set_scale(Vector2(2, 2))
	else:
		b.set_scale(Vector2(1, 1))