extends Control

@onready var fade_screen = $"fade away"
@onready var play_button = $Button # Adjust this if your button has a different name

func _ready():
	# Make sure the fade screen is completely transparent when the menu loads
	fade_screen.modulate.a = 0.0

func _on_button_pressed():
	# Disable the button so the player can't click it twice during the fade
	play_button.disabled = true
	
	# Create a code animator
	var tween = get_tree().create_tween()
	
	# Animate the fade screen's transparency (alpha) to 1.0 (solid) over 1.5 seconds
	tween.tween_property(fade_screen, "modulate:a", 1.0, 1.5)
	
	# When the 1.5 second fade finishes, call the function to load the game
	tween.finished.connect(_load_game)

func _load_game():
	get_tree().change_scene_to_file("res://Joey.tscn")
