
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func new_time(h, m, s):
	var t = {}
	t['hour'] = h
	t['minute'] = m
	t['second'] = s
	return t

func lpad(thing, length, char=' '):
	var s = str(thing)
	
	for i in range(length - s.length()):
		s = char + s
	return s

func time_to_s(time):
	var t = lpad(time['hour'], 2, '0') + ':' + \
	        lpad(time['minute'], 2, '0') + ':' + \
	        lpad(time['second'], 2, '0')
	return t

func subtract_time(now, past):
	pass

func _ready():
	var t = OS.get_time(true)
	print(str(t))
	print(time_to_s(t))
	
	print(time_to_s(new_time(0, 0, 0)))
	print(time_to_s(new_time(1, 1, 1)))
	print(time_to_s(new_time(11, 11, 11)))
	

