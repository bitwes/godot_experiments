#current speed.
var speed = 0
# desired speed
var target_speed = 0
# acceleration used to get from speed to target_speed
var acceleration = 20
# The other car to match
var other_car = null
# default acceleration to use for matching.  this
# is used in calculations as a guide to determine 
# if we should match speeds or not.
var match_accel = 700.0
# flag to indicate if we are matching.  Used to not
# continuously try to match speeds since we want to
# get it right on first calculation.
var matching = false
# the most distance we want to cover backwards
# before we are up to speed with the other car.
var max_backup = 100

func _ready():
	set_fixed_process(true)
	add_user_signal('match')
	
func _fixed_process(delta):
	if(other_car != null):
		match(other_car)
	_approach(delta, acceleration)
	set_pos(get_pos() + Vector2(speed * delta, 0))
	get_node("InfoLabel").set_text(to_s())
	
func match(car):
	if(matching):
		# don't collide with other car since the rest
		# isn't perfect.
		if(distance_to(car) < 10 and speed != car.speed):
			print("!! Well shit, we're gonna hit him.")
			speed = car.speed
		return
		
	var pad = 10
	var time_to_match = ttm(car)
	var ttos = abs((speed - car.speed)/match_accel)
	
	if(time_to_impact(car) < .5):
		# start stopping if moving forward
		# not perfect, if other car too slow, we
		# stop early and wait, but it's better
		# than without it.
		if(speed > 0):
			target_speed = 0
			acceleration = 1000
			return

		#print('--- matching ---')
		emit_signal('match')
		matching = true
		var stop_dis = 0
		if(speed > 0):
			var t_stop = (speed/(speed - car.speed)) * t
			t = t - t_stop
			stop_dis = get_distance_to_stop(t_stop)
			#print(str('t_stop = ', t_stop))
			#print(str('stop dist = ', stop_dis))
		
		var dis = max_backup + stop_dis + pad
		acceleration = (2.0 * (dis - (speed * t)))/pow(t,2)
		target_speed = car.speed
		#print(str('total distance = ', dis))
		#print(str('t = ', t))
		#print(str('ttm = ', time_to_match))
		


func get_distance_to_stop(t):
	var v0 = speed
	var a = speed/t
	var s =(v0 * t) + (.5 * a * pow(t,2))
	return s

func to_s():
	var to_return = str('speed = ', speed, "\n")
	to_return += str("target_speed = ", target_speed, "\n")
	to_return += str("accel = ", acceleration, "\n")
	to_return += str('tts = ', time_to_target_speed(), "\n")
	to_return += str('pos = ', get_pos())
	
	if(other_car != null):
		to_return += "\n\n-----\n"
		to_return += str("tti = ", time_to_impact(other_car), "\n")
		to_return += str("ttm = ", ttm(other_car), "\n")
		to_return += str("ttos = ", abs((speed - other_car.speed)/match_accel), "\n")
		to_return += str('distance = ', distance_to(other_car))
	return to_return
	
func ttm(car):
	return abs((distance_to(car) + max_backup)/car.speed)

# ##############
# Not changed
# ##############
func _approach(delta, accel):
	if(accel == 0):
		speed = target_speed
	
	if(speed != target_speed):
		var dir = sign(target_speed - speed)
		var increment = delta * abs(accel) * dir
		
		if(dir > 0):
			if(speed + increment > target_speed):
				speed = target_speed
			else:
				speed += increment
		else:
			if(speed + increment < target_speed):
				speed = target_speed
			else:
				speed += increment

func time_to_target_speed():
	var to_return = 0
	if(acceleration != 0):
		to_return = abs((target_speed - speed) / acceleration)
	return to_return
	
func time_to_impact(car):
	var to_return = 9999
	var dist = distance_to(car)
	if((dist > 0 and car.speed > speed) or
	   (dist < 0 and car.speed < speed)):
		to_return = 9999
	else:
		var approach_speed = speed + car.speed * -1
		# if the signs match then we are appraoching
		#if(sign(approach_speed) == sign(get_speed())):
		if(approach_speed != 0):
			to_return = abs(abs(dist) / approach_speed)

	return to_return

func distance_to(car):
	var to_return = 0
	var center_dis = abs(get_pos().x - car.get_pos().x)

	if(center_dis < get_half_width() + car.get_half_width()):
		to_return = 0
	else:
		if(car.get_back_bumper_x() > get_front_bumper_x()):
			to_return = car.get_back_bumper_x() - get_front_bumper_x()
		else:
			to_return = car.get_front_bumper_x() - get_back_bumper_x()

	return to_return

func get_half_width():
	return get_node("Sprite").get_texture().get_width() / 2

func get_front_bumper_x():
	return get_pos().x + get_half_width()

func get_back_bumper_x():
	return get_pos().x - get_half_width()

	