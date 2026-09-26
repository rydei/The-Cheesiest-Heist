extends CanvasLayer

@onready var sub_viewport = $Control/RadarRing/MiniMap/SubViewport
@onready var map_camera = $Control/RadarRing/MiniMap/SubViewport/MapCamera
@onready var timer_label = $Control/TimerLabel
@onready var loot_text = $Control/HBoxContainer/LootText

var player
var time_elapsed: float = 0.0

func _ready():
	sub_viewport.world_3d = get_tree().root.get_viewport().world_3d
	player = get_tree().get_first_node_in_group("Player")
	if loot_text:
		loot_text.text = "0/5"

func _process(delta):
	if player:
		map_camera.global_position = Vector3(player.global_position.x, player.global_position.y + 30.0, player.global_position.z)
		
	time_elapsed += delta
	
	var total_seconds = int(time_elapsed)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _input(event):
	if event is InputEventKey and event.keycode == KEY_R and event.pressed:
		time_elapsed = 0.0

func update_cheese_ui(current_count: int):
	if loot_text:
		loot_text.text = str(current_count) + "/5"
