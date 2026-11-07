extends TextEdit

var next_sib = null
var prev_sib = null
var num_letters



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_theme_font_size_override("font_size",40);
	if(get_index()+1 < get_parent().get_child_count()):
		next_sib = get_parent().get_child(get_index()+1)
	if(get_index() > 0):
		prev_sib = get_parent().get_child(get_index()-1)
	num_letters = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_text_changed() -> void:
	
	if(text.contains("\n")):
		text = ""
	if(next_sib):
		next_sib.grab_focus.call_deferred()
	if(text.length() > 1):
		text = text[0]
		set_caret_column(1)
	text = text
	
	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Delete"):
		if(text.length() == 0):
			if(prev_sib):
				prev_sib.text = ""
				prev_sib.grab_focus.call_deferred()
			

	#pass # Replace with function body.
