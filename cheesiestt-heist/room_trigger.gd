extends Area3D

@export var room_name: String = "Garage"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Joey" or body.is_in_group("Player"):
		get_tree().call_group("HUD", "update_level_ui", room_name)
