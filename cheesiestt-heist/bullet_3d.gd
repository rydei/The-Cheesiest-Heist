extends Area3D

const SPEED := 20.0
var life := 3.0

func _physics_process(delta: float) -> void:
	position += -transform.basis.z * SPEED * delta
	life -= delta
	print("bullet at: ", global_position)
	if life <= 0.0:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	print("bullet touched: ", body.name)
	if body.is_in_group("target"):
		body.on_hit()
	queue_free()
