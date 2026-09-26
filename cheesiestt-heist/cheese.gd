extends Area3D

var player_near = false

func _ready():
	add_to_group("Cheese") # Automatically groups all cheeses together

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false

func _process(delta):
	# The 'and visible' check ensures Joey can't pick up invisible cheese
	if player_near and visible and Input.is_action_just_pressed("interact"):
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			player.collect_cheese()
		hide() # Makes the cheese disappear

func reset_item():
	show() # Brings the cheese back
