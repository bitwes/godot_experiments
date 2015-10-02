extends Node2D
var timer = Timer.new()

func _ready():
   add_child(timer)
   timer.set_one_shot(true)
   timer.set_wait_time(5)

func _on_startButton_pressed():
   var button = get_node("startButton")
   button.set_disabled(true)
   timer.start()
   yield(timer, 'timeout')
   button.set_disabled(false)

