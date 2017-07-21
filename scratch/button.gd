
extends Button

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	pass

func _pressed():
	print (str(sign( 1 - 1)))
	print (str(sign( 1 - 2)))
	print (str(sign( 2 - 1)))

	print("asdf".to_ascii()[0])