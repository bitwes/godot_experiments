
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var _output_label = null

func _ready():
	# Initialization here
	_output_label = get_node("Output")
	print(OS.get_cmdline_args())
	_output_label.set_text(str(OS.get_cmdline_args()))
