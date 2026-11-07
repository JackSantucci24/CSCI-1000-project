extends LineEdit

var next_sib = null
var prev_sib = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_theme_font_size_override("font_size",40);
	
	if(get_index()+1 < get_parent().get_child_count()):
		next_sib = get_parent().get_child(get_index()+1)
	if(get_index() > 0):
		prev_sib = get_parent().get_child(get_index()-1)

func _on_text_changed(new_text: String) -> void:
	
	if(new_text.contains("\n")):
		new_text = ""
	if(next_sib):
		next_sib.grab_focus.call_deferred()

	if(new_text.length() > 1):
		text = new_text[0]
		set_caret_column(1)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Delete"):
		if(text.length() == 0):
			if(prev_sib):
				prev_sib.text = ""
				prev_sib.grab_focus.call_deferred()




	
