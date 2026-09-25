extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("set_nearby_gun"):
		body.set_nearby_gun(get_parent())
		
func _on_body_exited(body: Node3D) -> void:
	if body.has_method("clear_nearby_gun"):
		body.clear_nearby_gun(get_parent())
