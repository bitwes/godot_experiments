# -----------------------------------------------------------------------------
# Proof of concept in changing an animation's object at runtime.  This works
# pretty good but only on an animation that has a single object and the new
# object has all the same properties.
# 
# This kind of stuff might make it easy to reuse animations created at design
# time.  Chances are though this isn't going to work out that great generically.
# Seems like a method that has intimate knowledge of the animations would be
# better at changing the object an animation animates.
#
# Pretty good illustration of how to do it none-the-less.
# -----------------------------------------------------------------------------
onready var anim = get_node('AnimationPlayer')

class AnimationSwitcher:
	var _player = null
	
	func set_player(player):
		_player = player
	
	# change all tracks in an animation to point to the 
	# new path.  Assumes a lot:
	#  The animation only affects one object
	#  Each track operates on a property (this might be a safe assumption)
	#  The NodePath returned from track_get_path only has one name (might be safe too)
	#  The object at new_target_path has all the properties that the object in the track does
	#  new_target_path is valid
	#  Each track path doesn't have a subname (i don't know what these are)
	func change_animation_object(name, new_target_path):
		var anim = _player.get_animation(name)
		for i in range(anim.get_track_count()):
			var path = anim.track_get_path(i)
			var new_path = NodePath(new_target_path + ':' + path.get_property())
			anim.track_set_path(i, new_path)
			
var _anim_switcher = AnimationSwitcher.new()

func _ready():
	_anim_switcher.set_player(anim)

func _on_Spin1Button_pressed():
	switch_animation('Sprite1')
	anim.play('spin')

func _on_Spin2Button_pressed():
	switch_animation('Sprite2')
	anim.play('spin')

# manual switching of one thing
func switch_animation(new_target_path):
	var a = anim.get_animation('spin')
	a.track_set_path(0, new_target_path + ':transform/rot')
	
func _on_BunchOfStuff_pressed():
	_anim_switcher.change_animation_object('bunch_of_stuff', 'Sprite2')
	anim.play('bunch_of_stuff')

func _on_BunchOfStuffComplicated_pressed():
	_anim_switcher.change_animation_object('bunch_of_stuff', 'more/complicated/path/Sprite3')
	anim.play('bunch_of_stuff')


func _on_ComplicatedPath_pressed():
	_anim_switcher.change_animation_object('more_complicated_path', 'Sprite2')
	anim.play('more_complicated_path')
