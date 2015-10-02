tool
extends WindowDialog

var _hide_button = null
var _copy_button = null
var _clear_button = null
var _text_box = null
var _opacity_slider = null

var _object_count_label = null
var _entries = []
var _mouse_down = false
var _mouse_down_pos = null
var _mouse_in = false

var print_to_console = false
var enabled = true
var show_object_count = true

var min_size = Vector2(430, 150)

func _init():
	set_size(min_size)
	
	_hide_button = Button.new()
	_hide_button.set_text("Hide")
	_hide_button.connect("pressed", self, "_on_hide_pressed")
	add_child(_hide_button)
	
	_copy_button = Button.new()
	_copy_button.set_text("Copy")
	_copy_button.connect("pressed", self, "_on_copy_pressed")
	add_child(_copy_button)

	_clear_button = Button.new()
	_clear_button.set_text("Clear")
	_clear_button.connect("pressed", self, "_on_clear_pressed")
	add_child(_clear_button)

	_text_box = TextEdit.new()
	_text_box.set_wrap(false)
	_text_box.set_readonly(true)
	add_child(_text_box)
	
	_object_count_label = Label.new()
	_object_count_label.set_text("ObjCount")
	add_child(_object_count_label)
	
	_opacity_slider = HSlider.new()
	_opacity_slider.set_min(10)
	_opacity_slider.set_max(100)
	_opacity_slider.set_value(100)
	_opacity_slider.connect("value_changed", self, "_on_opacity_slider_changed")
	add_child(_opacity_slider)
	
	self.set_title("Debug Output")
		
func _ready():
	set_process(true)
	set_process_input(true)
	
	_hide_button.set_size(Vector2(100, 50))
	_hide_button.set_pos(self.get_size() - _hide_button.get_size() - Vector2(10, 10))
	_hide_button.set_anchor(MARGIN_LEFT, ANCHOR_END)
	_hide_button.set_anchor(MARGIN_RIGHT, ANCHOR_END)
	_hide_button.set_anchor(MARGIN_TOP, ANCHOR_END)
	_hide_button.set_anchor(MARGIN_BOTTOM, ANCHOR_END)
	
	_copy_button.set_size(Vector2(100, 50))
	_copy_button.set_pos(_hide_button.get_pos() - Vector2(110, 0))
	_copy_button.set_anchor(MARGIN_LEFT, ANCHOR_END)
	_copy_button.set_anchor(MARGIN_RIGHT, ANCHOR_END)
	_copy_button.set_anchor(MARGIN_TOP, ANCHOR_END)
	_copy_button.set_anchor(MARGIN_BOTTOM, ANCHOR_END)

	_clear_button.set_size(Vector2(100, 50))
	_clear_button.set_pos(_copy_button.get_pos() - Vector2(110, 0))
	_clear_button.set_anchor(MARGIN_LEFT, ANCHOR_END)
	_clear_button.set_anchor(MARGIN_RIGHT, ANCHOR_END)
	_clear_button.set_anchor(MARGIN_TOP, ANCHOR_END)
	_clear_button.set_anchor(MARGIN_BOTTOM, ANCHOR_END)

	_text_box.set_size(self.get_size() - Vector2(6, 70))
	_text_box.set_pos(Vector2(3, 3))
	_text_box.set_anchor(MARGIN_LEFT, ANCHOR_BEGIN)
	_text_box.set_anchor(MARGIN_RIGHT, ANCHOR_END)
	_text_box.set_anchor(MARGIN_TOP, ANCHOR_BEGIN)
	_text_box.set_anchor(MARGIN_BOTTOM, ANCHOR_END)
	
	_object_count_label.set_size(Vector2(100, 30))
	_object_count_label.set_pos(Vector2(5, self.get_size().y - 30))
	_object_count_label.set_anchor(MARGIN_LEFT, ANCHOR_BEGIN)
	_object_count_label.set_anchor(MARGIN_TOP, ANCHOR_END)

	_opacity_slider.set_size(Vector2(85, 20))
	_opacity_slider.set_pos(Vector2(5, self.get_size().y - 60))
	_opacity_slider.set_anchor(MARGIN_LEFT, ANCHOR_BEGIN)
	_opacity_slider.set_anchor(MARGIN_TOP, ANCHOR_END)
	_opacity_slider.set_anchor(MARGIN_TOP, ANCHOR_END)
	
func _process(delta):
	if(show_object_count and enabled):
		_object_count_label.set_text("Count = " + str(get_tree().get_node_count()))

func _input(event):
	
	#if the mouse is somewhere within the debug window
	if(_mouse_in):
		#Check for mouse click inside the resize handle
		if(event.type == InputEvent.MOUSE_BUTTON):
			if (event.button_index == 1):
				#It's checking a square area for the bottom right corner, but that's close enough.  I'm lazy
				if(event.pos.x > get_size().x + get_pos().x - 10 and event.pos.y > get_size().y + get_pos().y - 10):
					if event.pressed:
						_mouse_down = true
						_mouse_down_pos = event.pos
					else:
						_mouse_down = false
		#Reszie
		if(event.type == InputEvent.MOUSE_MOTION):
			if(_mouse_down):
				if(get_size() >= min_size):
					var new_size = get_size() + event.pos - _mouse_down_pos
					var new_mouse_down_pos = event.pos
					
					if(new_size.x < min_size.x):
						new_size.x = min_size.x
						new_mouse_down_pos.x = _mouse_down_pos.x
					
					if(new_size.y < min_size.y):
						new_size.y = min_size.y
						new_mouse_down_pos.y = _mouse_down_pos.y
						
					_mouse_down_pos = new_mouse_down_pos
					set_size(new_size)
					

func _draw():
	#Draw the lines in the corner to show where you can
	#drag to resize the dialog
	var grab_margin = 2
	var line_space = 3
	var grab_line_color = Color(.4, .4, .4)
	for i in range(1, 6):
		draw_line(get_size() - Vector2(i * line_space, grab_margin), get_size() - Vector2(grab_margin, i * line_space), grab_line_color)

func _on_debug_mouse_enter():
	_mouse_in = true

func _on_debug_mouse_exit():
	_mouse_in = false
	_mouse_down = false

func _on_hide_pressed():
	self.hide()

func _on_copy_pressed():
	_text_box.select_all()
	_text_box.copy()
	_text_box.select(0, 0, 0, 0)

func _on_clear_pressed():
	_entries.clear()
	_text_box.set_text("")

func _on_opacity_slider_changed(value):
	self.set_opacity(value/100)
	
func p(text):
	if(enabled):
		var entry = DebugEntry.new()
		var last_entry = null
		#indent any extra lines in the text so that all the text lines up
		var to_print = str(text)
		to_print = to_print.replacen("\n", "\n\t\t\t\t\t")
		
		if(!_entries.empty()):
			last_entry = _entries[_entries.size() -1]
		
		#If the entry is the same then we clear out the last entry so we can print the new
		#one with a higher counter.
		if(last_entry != null and to_print.casecmp_to(last_entry.text) == 0 and last_entry.timestamps_equal(entry)):
			last_entry.count += 1
			
			#count the lines in the text.
			var lines = 1
			if(!to_print.empty()):
				lines = 1
				var where = to_print.findn("\n", 0)
				while(where != -1):
					lines += 1
					where = to_print.findn("\n", where +1)
			
			#Selecting text then inserting at cursor will replace the 
			#text that is selected.  This erases that text since we
			#have a duplicate
			_text_box.select(0, 0, lines, 0)
			_text_box.insert_text_at_cursor("")
		else:
			entry.text = to_print
			_entries.append(entry)
			
		_text_box.cursor_set_column(0)
		_text_box.cursor_set_line(0)
		_text_box.insert_text_at_cursor(_entries[_entries.size() - 1].to_string() + "\n")

		if(print_to_console):
			print("[" + entry.get_timestamp_as_string() + "] " + to_print)

################################################################################
#DebugEntry Class
#	Data structure for a debug entry with some methods for getting data back 
#	out as a string.  The timestamp is set when new() is called, so you don't 
#	have to do that unless you don't want to use the time it was created as 
#	the timestamp.
################################################################################
class DebugEntry:
	var text = ""
	var timestamp = null
	var count = 1
	
	func _init():
		timestamp = OS.get_time()
	
	func get_timestamp_as_string():
		return str(timestamp['hour']).pad_zeros(2) + ":" + str(timestamp['minute']).pad_zeros(2) + ":" + str(timestamp['second']).pad_zeros(2)
	
	func to_string():
		var to_return = "[" + get_timestamp_as_string() + "]\t" + text
		if(count > 1):
			to_return += "  (" + str(count) + ")"
		
		return to_return
	
	func timestamps_equal(other_entry):
		return other_entry.get_timestamp_as_string().casecmp_to(self.get_timestamp_as_string()) == 0




