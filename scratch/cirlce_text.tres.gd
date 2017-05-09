

func ready():
	update()


func _draw():
	var font = get_node("font_label").get_font('')
	draw_cirlce_text('hello there friend how are you today?', font, Vector2(200, 200), 100, Color(.75, .25, .25))
	
func hardcoded_circle_text():
	var font = get_node("font_label").get_font('')
	var my_string = "Hello World"
	var x = (360) / my_string.length()
	for i in range(0, my_string.length()):
	    draw_set_transform(Vector2(0, 0), deg2rad(i * x - (my_string.length()/2*x)), Vector2(1,1))
	    draw_char(font, Vector2(0, -30), my_string[my_string.length()-i-1], "", Color(0, 0, 0))

func draw_cirlce_text(text, font, origin, radius, color=Color(0, 0, 0)):
	var x = (360) / text.length()
	var scale = Vector2(1, 1)
	for i in range(0, text.length()):
		var rotation = deg2rad( (i * x) - ((text.length()/2) * x) )
		draw_set_transform(origin, rotation, scale)
		draw_char(font, Vector2(0, - radius), text[text.length()-i-1], "", color)
	