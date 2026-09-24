
extends Area3D

@export var zip_start: Node3D
@export var zip_end: Node3D
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node3D) -> void:
	if body.has_method("set_nearby_zipline"):
		body.set_nearby_zipline(self)
		
func _on_body_exited(body: Node3D) -> void:
	if body.has_method("clear_nearby_zipline"):
		body.clear_nearby_zipline(self)
