
extends Node2D


class DistanceSpeed:
	var _distances = []
	var _speeds = []
	var _default = 0
	
	func _init(default):
		_default = default
	
	func add(distance, speed):
		_distances.append(distance)
		_speeds.append(speed)
	
	func get_speed(traveled):
		var idx = 0
		var total = 0
		var the_one = -2
		
		if(_distances.size() == 0 ):
			return _default
		
		if(_distances[0] > traveled):
			return _default
		
#		while(total <= traveled and idx < _distances.size()):
#			total += _distances[idx]
#			idx += 1
#		
#		if(total > traveled):
#			the_one = idx -1
		while(idx < _distances.size() and the_one == -2):
			total += _distances[idx]
			if(traveled > total):
				idx += 1
			else:
				the_one = idx
			
		
		#if(idx > _distances.size()):
		#	the_one = idx -1
		
		if(the_one < 0):
			return _default
		else:
			return _speeds[the_one]


class DistanceSpeedChanger:
	extends Node2D
	var ds = null
	
	var _traveled = 0
	var _sprite = null
	var _cur_speed = 0
	var _target_speed = 0
	var _acceleration = 150
	
	func _init(base_speed, sprite):
		_sprite = sprite
		_target_speed = base_speed
		ds = DistanceSpeed.new(base_speed)
		
	func _approach(delta):
		if(_cur_speed != _target_speed):
			if(_target_speed < _cur_speed):
				var increment = delta * _acceleration * -1
				if(_cur_speed + increment < _target_speed):
					_cur_speed = _target_speed
				else:
					_cur_speed += increment
			else:
				var increment = delta * _acceleration
				if(_cur_speed + increment > _target_speed):
					_cur_speed = _target_speed
				else:
					_cur_speed += increment
			
	func move(delta):
		var v = Vector2(0, 0)
		_target_speed = ds.get_speed(_traveled)
		_approach(delta)
		
		v.x = _cur_speed * delta
		# Do not increment traveled until we are AT speed so that we know
		# the car will travel at the desired speed for the desired distance.
		# This cuts out the acceleration from the traveled.
		if(_cur_speed == _target_speed):
			_traveled += abs(v.x)
		
		_sprite.set_pos(_sprite.get_pos() + v)
		_sprite.get_node("speed").set_text('speed:  ' + str(_cur_speed) + ' target:  ' + str(_target_speed))
		_sprite.get_node("Label").set_text("traveled: " + str(_traveled))

	func add_distance(distance, speed):
		ds.add(distance, speed)




var back_forth = null
var slow_in_middle = null
var distanced = null

var count = 0
func _ready():
	back_forth = get_node("back_forth")
	slow_in_middle = get_node("slow_in_middle")
	
	distanced = DistanceSpeedChanger.new(100, get_node("distanced"))
	distanced.add_distance(200, 0.5)
	distanced.add_distance(5, -100)
	#distanced.add_distance(5, 100)
	#distanced.add_distance(5, -100)
	#distanced.add_distance(5, 100)
	#distanced.add_distance(5, -100)
	#distanced.add_distance(100, 250)

#	#distanced.add_distance(200, 100)
#	distanced.add_distance(75, 50)
#	distanced.add_distance(100, -150)
#	distanced.add_distance(100, -2000)
#	distanced.add_distance(50, .5)
#	distanced.add_distance(20, 150)
	set_process(true)
	
func _process(delta):
	back_forth.set_pos(back_forth.get_pos() + Vector2(2 * sin(count), 0))
	
	# slow in middle
#	var slow_count = count -3
#	var slow = pow(float(slow_count), 3.0) +  pow(float(slow_count), 2.0)
#	if(slow_count < 0):
#		slow = abs(slow)
#	slow_in_middle.set_pos(slow_in_middle.get_pos() + Vector2(slow/3, 0))

	count += delta
	distanced.move(delta)