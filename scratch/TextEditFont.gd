# First import the font.  I imported into same directory (there was only ttf 
# files in there to begin with).
#	I imported VeraMono.ttf

onready var _text_edit = get_node("TextEdit")
onready var _rich_label = get_node("Panel/RichTextLabel")
const FONT_PATH = 'res://font/VeraMono/VeraMono.fnt'
var _font = load(FONT_PATH)

func get_method_name_array(obj):
	var lst = obj.get_method_list()
	var names = []
	for i in range(lst.size()):
		names.append(lst[i].name)
	names.sort()
	return names

func _override_font():
	_text_edit.add_font_override('font', _font)

func _override_dyanmic_font():
	var f = DynamicFont.new()
	var fd = DynamicFontData.new()
	fd.set_font_path(FONT_PATH)
	f.set_font_data(fd)
	f.set_size(100)
	f.update_changes()
	_text_edit.add_font_override('font', f)

func _set_label_font():
	_rich_label.push_font(_font)
	
func _ready():
	#_override_font()
	_override_dyanmic_font()
	
	#print(_text_edit.get_default_theme().get_font_list())
	var text = "This is some multiline\ntext going right in here for you to see\n" + \
	                    "1\n 2\n  3\n   4\n" + \
	                    "1234567890\n" + \
	                    "1\n 2\n  3\n   4\n" + \
	                    "abcdefghijklmnopqrstuvwxyz"
	_text_edit.set_text(text)
	
	
	
	_set_label_font()
	_rich_label.add_text(text)
	_rich_label.set_selection_enabled(true)
	_rich_label.set_tab_size(2)
	for i in range(5):
		_rich_label.push_indent(i)
		_rich_label.add_text(str(i, i, i, i, i))
	
	for i in range(5):
		_rich_label.pop()
	_rich_label.push_indent(-5)
	_rich_label.add_text("\npost_pop")
	get_node("ManuallyChanged").set_text(text)
	
	var method_text = ""
	var names = get_method_name_array(_rich_label)
	for i in range(names.size()):
		method_text += str(names[i], "\n")
	
	get_node("ManuallyChanged").set_text(method_text)