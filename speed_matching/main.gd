var orig = {
	car1_pos = null,
	car2_pos = null
}

var car1 = {
	car = null,
	speed = 0,
	target_speed = 200,
	acceleration = 400,
	starting_pos = null
}

var car2 = {
	car = null,
	speed = 0,
	target_speed = -400,
	acceleration = 0,
	starting_pos = null
}
var _paused = false

func _ready():
	car1.car = get_node("Car1")
	car1.starting_pos = car1.car.get_pos()
	
	car2.car = get_node("Car2")
	car2.starting_pos = car2.car.get_pos()
	car1.car.other_car = car2.car
	_reset_cars()
	get_node("Car1TargetSpeed").set_value(car1.target_speed)
	get_node("Car2TargetSpeed").set_value(car2.target_speed)	
	go()

func _reset_car(car):
	car.car.speed = car.speed
	car.car.target_speed = 0
	car.car.acceleration = car.acceleration
	car.car.set_pos(car.starting_pos)
	car.car.matching = false

func _reset_cars():
	_reset_car(car1)
	_reset_car(car2)


func _on_ResetButton_pressed():
	_reset_cars()
	go()
	
func go():
	car1.car.target_speed = car1.target_speed
	car2.car.target_speed = car2.target_speed
	
func _toggle_pause():
	_paused = !_paused
	get_tree().set_pause(_paused)

func _on_PauseButton_pressed():
	_toggle_pause()
	var btn = get_node("PauseButton")
	if(_paused):
		btn.set_text("Run")
	else:
		btn.set_text("Pause")

func _move_car(car, x):
	car.set_pos(car.get_pos() + Vector2(x, 0))

func _on_MoveRightButton_pressed():
	_move_car(car1.car, 100)
	_move_car(car2.car, 100)

func _on_MoveLeftButton_pressed():
	_move_car(car1.car, -100)
	_move_car(car2.car, -100)

func _on_Car1TargetSpeed_value_changed( value ):
	get_node("Car1TargetSpeed/Value").set_text(str(value))
	car1.target_speed = value

func _on_Car2TargetSpeed_value_changed( value ):
	get_node("Car2TargetSpeed/Value").set_text(str(value))
	car2.target_speed = value
