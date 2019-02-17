extends SceneTree

var _seed = 1

func reseed():
	seed(_seed)
	randi() # burn one, first is always 0

func fill_rands(how_many=100):
	var rands = {}
	rands['randi'] = []
	reseed()
	for i in range(how_many):
		rands.randi.append(randi())

	rands['randf'] = []
	reseed()
	for i in range(how_many):
		rands.randf.append(randf())

	print(rands.randi)
	print()
	print(rands.randf)

	return rands


func _init():
	fill_rands()
	quit()
