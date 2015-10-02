
extends Node2D
var _dbg = load("res://bitwes_tools/scripts/debug.gd").new()

var _area = null
var _kin_with_shape = null
var _kin_no_shape = null
var _kin_with_area = null

const SPEED = 200

func _ready():
	set_process(true)
	add_child(_dbg)
	_dbg.set_pos(Vector2(10, 50))
	_area = get_node("./area")
	_kin_with_shape = get_node("./kinWithShape")
	_kin_no_shape = get_node("./kinNoShape")
	_kin_with_area = get_node("./kinNoShapeHasArea")

func _do_move(obj, delta):
	obj.move(Vector2(SPEED * delta, 0))

func _process(delta):
	_do_move(_kin_with_shape, delta)
	_do_move(_kin_with_area, delta)
	_do_move(_kin_no_shape, delta)

func _on_area_body_enter( body ):
	_dbg.p("area:  body entered")

func _on_ShowDebugButton_pressed():
	_dbg.show()
