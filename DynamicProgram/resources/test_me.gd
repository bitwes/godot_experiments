extends Node2D

var MockMe = load('res://resources/mock_me.gd')
var ExtendedMockMe = load('res://resources/extends_mock_me.gd')

# this is a comment
func _init():
    var mm = MockMe.new()
    mm.print_hello_world()
    print('returns_a_value = ', mm.returns_a_value())

func this_is_it():
    print('this is it')
