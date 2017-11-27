# stuff.
onready var anim = get_node('AnimationPlayer')


func _on_MakeFlashWhite_pressed():
	var img = get_node('FlashWhiteSprite')
	img.get_material().set_shader_param('should', true)
	anim.play('flash_white')
	
	

