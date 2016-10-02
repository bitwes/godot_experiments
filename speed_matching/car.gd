var speed = 0
var target_speed = 0
var acceleration = 20
var other_car = null
var match_accel = 1000

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(other_car != null):
		match(other_car)
	_approach(delta, acceleration)
	set_pos(get_pos() + Vector2(speed * delta, 0))
	get_node("InfoLabel").set_text(to_s())
	
func match(car):
	var tti = time_to_impact(car)
	var tts = abs((car.speed - speed) / match_accel)
	var accel_to_match = abs((speed - car.speed) / tti)

	if(accel_to_match >= match_accel):
		acceleration = accel_to_match
		target_speed = car.speed

func _approach(delta, accel):
	if(accel == 0):
		speed = target_speed
	
	if(speed != target_speed):
		var dir = 1
		if(target_speed < speed):
			dir = -1
		
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

func to_s():
	var to_return = str('speed = ', speed, "\n")
	to_return += str("target_speed = ", target_speed, "\n")
	to_return += str("accel = ", acceleration, "\n")
	to_return += str('tts = ', time_to_target_speed())
	if(other_car != null):
		to_return += str("\ntti = ", time_to_impact(other_car), "\n")
	return to_return
	
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