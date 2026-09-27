extends Area3D

@export var respawn_point: Node3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	print("lava touched by: ", body.name)
	if respawn_point != null and body.has_method("respawn_at"):
		body.respawn_at(respawn_point.global_position)
	
func _on_body_entered(body: Node3D) -> void:
	print("Lava touched by: ", body.name)
	if respawn_point != null and body.has_method("respawn_at"):
		body.respawn_at(respawn_point.global_position) 
