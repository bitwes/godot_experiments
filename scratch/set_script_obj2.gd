
extends 'res://set_script_obj.gd'

var _other_prop = 'something else'

func render_label_text():
	var txt = .render_label_text()
	txt += "\nother_prop = " + _other_prop
	return txt

