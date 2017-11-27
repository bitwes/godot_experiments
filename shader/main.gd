# -----------------------------------------------------------------------------
# This has a simple shader that adds an amount of white to the sprite.  I 
# toyed with making an animation and what happens when two materials are 
# the same.  Turns out it's kinda interesting and annoying.  The names of
# the Sprites don't exactly match up so here is what each one is and how
# it works:
#
# FlashWhiteSprite is has an associated animation that will change the value
# of the shader parameter "amount" to make it flash white.
#
# DontFlash was "duplicated" from FlashWhiteSprite which means it has the same
# material as FlashWhiteSprite.  If you play the 'flash_white' animation in
# the editor both will flash.  In _ready I duplicate the material making it
# a different one so at runtime they both don't flash.  This is similar to
# what you have to do as a workaround when instancing a new sprite that you
# do not want to flash with all the other instances.  I setup a different 
# animation in the animation player called 'flash_other' that flashes just
# DontFlash.  If you run that in the editor you will see both flash too.
# 
# HandMade is another Sprite that is setup the same as FlashWhiteSprite but
# it was done by hand and not duplicated from either FlashWhiteSprite or 
# DontFlash.
#
# When you run this scene you'll see that you can flass FlashWhiteSprite 
# and DontFlash independently and that HandMade doesn't flash at all.
# -----------------------------------------------------------------------------
onready var anim = get_node('AnimationPlayer')

func _ready():
	# to make the two materials different (since one was copied from the other) you have
	# to duplicate the material.
	var dont_flash = get_node('DontFlash')
	dont_flash.set_material(dont_flash.get_material().duplicate())
	
func _on_MakeFlashWhite_pressed():
	var img = get_node('FlashWhiteSprite')
	img.get_material().set_shader_param('should', true)
	anim.play('flash_white')
		
func _on_FlashTheDontFlash_pressed():
	anim.play('flash_other')
