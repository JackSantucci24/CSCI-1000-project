extends Node
class_name WordGroup

# One category: a name, its four words, and its banner color.

var group_name: String
var words: Array
var color: Color


func _init(p_name: String, p_words: Array, p_color: Color) -> void:
	group_name = p_name
	words = p_words
	color = p_color
