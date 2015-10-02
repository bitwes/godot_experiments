
extends Node2D
var _fire_count = 0
var _tap_timer = Timer.new()

var sprites = {
		left = null,
		right = null,
	}

var touches = {
		one = false,
		two = false,
		hold = false
	}

func _ready():
	sprites.left = get_node("LeftTouchSprite")
	sprites.right = get_node("RightTouchSprite")
	
	for key in sprites:
		sprites[key].set_opacity(0.25)
	
	set_process(true)
	set_process_unhandled_input(true)
	
	add_child(_tap_timer)
	_tap_timer.set_wait_time(.25)
	_tap_timer.connect('timeout', self, '_on_tap_timer_timeout')
	
func _process(delta):
	for key in sprites:
		sprites[key].set_opacity(0.25)
	
	if(touches.one):
		sprites.left.set_opacity(1)
	if(touches.two):
		sprites.right.set_opacity(1)

func _add_remove_touch(pressed):
	var old_state = touches.one or touches.two
	
	if(pressed):
		if(touches.one):
			touches.two = true
			touches.hold = false
			_tap_timer.start()
		else:
			touches.one = true
	else:
		if(touches.two):
			if(!touches.hold):
				fire()
				_tap_timer.stop()
			touches.two = false
		else:
			touches.one = false

	if(old_state and !(touches.one or touches.two)):
		fire()


func _unhandled_input(event):
	
	
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == 1 or event.button_index == 2):
			_add_remove_touch(event.pressed)

	if(event.type == InputEvent.SCREEN_TOUCH and !event.is_echo()):
		_add_remove_touch(event.pressed)
	
		
func _on_tap_timer_timeout():
	touches.hold = true
	_tap_timer.stop()
func fire():
	_fire_count += 1
	print('FIRE ' + str(_fire_count))