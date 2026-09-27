extends StaticBody3D

@export var Dmarker: Marker3D
@export var required_item_count: int = 6

@onready var trigger_area: Area3D = $TriggerArea

var player_on_pad: CharacterBody3D = null

func _ready() -> void:
	trigger_area.body_entered.connect(_on_trigger_body_entered)
	trigger_area.body_exited.connect(_on_trigger_body_exited)
	
func _on_trigger_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and body is CharacterBody3D:
		player_on_pad = body
			
func _on_trigger_body_exited(body: Node3D) -> void:
	if body == player_on_pad:
		player_on_pad = null
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_on_pad != null:
		check_and_teleport()
		
func check_conditions() -> bool:
	if player_on_pad != null:
		return player_on_pad.cheese_count >=  required_item_count
	return false
	
func check_and_teleport() -> void:
	if player_on_pad != null and Dmarker != null and check_conditions():
		player_on_pad.global_position = Dmarker.global_position
		player_on_pad.velocity = Vector3.ZERO
		player_on_pad.global_rotation.y = Dmarker.global_rotation.y
		player_on_pad = null
