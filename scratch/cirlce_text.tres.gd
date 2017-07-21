func ready():
	update()


func _draw():
	var font = get_node("font_label").get_font('')
	draw_cirlce_text('hello there friend how are you today?', font, Vector2(200, 200), 100, Color(.75, .25, .25))

# adapted from cdqwertz's forum post at
# https://godotdevelopers.org/forum/discussion/comment/19449#Comment_19449
func draw_cirlce_text(text, font, origin, radius, color=Color(0, 0, 0)):
	var x = (360) / text.length()
	var scale = Vector2(1, 1)
	for i in range(0, text.length()):
		var rotation = deg2rad( (i * x) - ((text.length()/2) * x) )
		draw_set_transform(origin, rotation, scale)
		draw_char(font, Vector2(0, - radius), text[text.length()-i-1], "", color)
	