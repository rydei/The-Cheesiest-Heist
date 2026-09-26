extends StaticBody3D

@export var paintings: Array[NodePath]
var triggered := false

func _ready() -> void:
	print("button ready, count: ", paintings.size())
	for path in paintings:
		var p := get_node(path)
		print("hiding node: ", p.name, " type: ", p.get_class())
		set_painting(p, false)
		print("  visible now: ", p.visible)

func on_hit() -> void:
	if triggered:
		return
	triggered = true
	print("BUTTON HIT — paintings appear")

	for path in paintings:
		set_painting(get_node(path), true)

func set_painting(p: Node3D, on: bool) -> void:
	p.visible = on
	for child in p.get_children():
		if child is CollisionShape3D:
			child.set_deferred("disabled", not on)
