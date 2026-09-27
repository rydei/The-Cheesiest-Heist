extends CanvasLayer

func _ready():
	hide()
@onready var controls_panel = $ControlsPanel

func _ready():
	hide()
	controls_panel.hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	if new_pause_state:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		controls_panel.hide() # Hide controls panel if we unpause using Escape

func _on_resume_button_pressed():
	toggle_pause()

func _on_controls_button_pressed():
	controls_panel.show()

func _on_close_controls_button_pressed():
	controls_panel.hide()

func _on_main_menu_button_pressed():
	get_tree().paused = false # Unfreeze the engine before leaving!
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
