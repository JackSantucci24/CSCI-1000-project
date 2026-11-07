extends HBoxContainer
var num_tries 
var is_active = true
@onready var wordle: Node2D = $".."

var secret_word
var pop_letter
var is_won

const YELLOW = preload("uid://doxcpeqr75n7a")
const GREEN = preload("uid://dds0v27kiyu12")
const GRAY = preload("uid://6y1k1ck1u3s4")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	secret_word = wordle.word 
	is_won = false
	num_tries = 0
	for i in range(get_child_count()):
		get_child(i).add_theme_stylebox_override("normal", GRAY)
		get_child(i).add_theme_stylebox_override("read_only", GRAY)
		get_child(i).add_theme_color_override("font_color", Color.LIGHT_GRAY)

func _clear():
	for i in range(get_child_count()):
		get_child(i).clear()
	get_child(0).grab_focus.call_deferred()

func _check_letters() -> bool:
	for i in range(get_child_count()):
		if(get_child(i).text == ""):
			return false
	return true
	
func _change_letters():
	var temp_word = secret_word
	var num_correct = 0
	for i in range(get_child_count()):
		if(get_child(i).text == secret_word[i]):
			pop_letter = secret_word.find(get_child(i).text)
			secret_word[pop_letter] = "^"
			get_child(i).add_theme_stylebox_override("read_only", GREEN)	
			get_child(i).add_theme_color_override("font_uneditable_color", Color.DARK_SLATE_GRAY)
			num_correct +=1
		elif(secret_word.contains(get_child(i).text)):
			pop_letter = secret_word.find(get_child(i).text)
			secret_word[pop_letter] = "^"
			if(temp_word[i] == get_child(i).text):
				get_child(i).add_theme_stylebox_override("read_only", GREEN)	
			else:
				get_child(i).add_theme_stylebox_override("read_only", YELLOW)
			get_child(i).add_theme_color_override("font_uneditable_color", Color.DARK_SLATE_GRAY)
		else:
			get_child(i).add_theme_color_override("font_uneditable_color", Color.LIGHT_GRAY)
	secret_word = temp_word
	if num_correct == 5:
		is_won = true
		print("win")
		
func _clear_letters():
	for i in range(get_child_count()):
		get_child(i).editable = false

func _input(event : InputEvent) -> void:	
	
	if(event.is_action_pressed("ui_accept")):
		if(num_tries < 5):
			if(is_active && _check_letters()):
				var new_duplicate = self.duplicate()
				new_duplicate.is_active = false
				self.get_parent().add_child(new_duplicate)
				global_position = global_position + Vector2(0, 90)
				num_tries+=1
				_clear()
				
				new_duplicate._clear_letters()
				new_duplicate._change_letters()
		else:
			_clear_letters()
			_change_letters()
			print(secret_word)
			
