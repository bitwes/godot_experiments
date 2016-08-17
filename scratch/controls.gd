
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var controls = {
	panel = null,
	tree = null
}

func create_title(tree, parent, text, columns=2, bg=Color(100, 100, 100)):
	var item = tree.create_item(parent)
	item.set_text(0, text)
	
	for i in range(columns):
		item.set_selectable(i, false)
		item.set_custom_bg_color(i, bg)
	
	return item

func populate_tree():
	var t = controls.tree
	t.set_columns(2)
	t.set_column_title(0, 'Title 1')
	t.set_column_title(1, 'Title 2')
	t.set_column_titles_visible(true)
	

	t.set_hide_root(false)
	
	var root = t.create_item()
	t.set_hide_root(true)
	
	var a = create_title(t, t.get_root(), 'a')
	
	var b = t.create_item(a)
	b.set_text(0, 'b')
	var c = t.create_item(b)
	c.set_text(0, 'c')
	
	var d = t.create_item(a)
	d.set_text(0, 'd')

	var e = create_title(t, t.get_root(), 'e')
	var e1 = t.create_item(e)
	e1.set_text(0, 'e1')
	var f = create_title(t, t.get_root(), 'f')
	var f1 = t.create_item(f)
	f1.set_text(0, 'f1')
	
	
	
func _ready():
	# Initialization here
	controls.panel = get_node("Panel")
	controls.tree = get_node("Panel/Tree")
	
	populate_tree()
	



