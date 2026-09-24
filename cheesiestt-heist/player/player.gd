extends CharacterBody3D

const WALK_SPEED = 20.0
const SPRINT_SPEED = 38.0
const ACCELERATION = 45.0
const DECELERATION = 40.0
const AIR_ACCELERATION = 40.0
const JUMP_VELOCITY = 27.0
const SPRINT_JUMP_BONUS = 16.0
const GRAVITY_UP = 30.0
const GRAVITY_DOWN = 50.0
const COYOTE_TIME = 0.15
const JUMP_BUFFER_TIME = 0.15
const ZIP_SPEED = 0.4

var coyote_timer = 0.0
var jump_buffer_timer = 0.0
var is_sprinting = false
var spawn_position: Vector3

var is_ziplining = false
var zip_t = 0.0
var nearby_zipline: Node = null
var zip_start_pos: Vector3
var zip_end_pos: Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawn_position = global_position

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.3
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -90.0, 90.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("reset"):
		reset_player()

func reset_player():
	global_position = spawn_position
	velocity = Vector3.ZERO

func set_nearby_zipline(zip: Node) -> void:
	nearby_zipline = zip

func clear_nearby_zipline(zip: Node) -> void:
	if nearby_zipline == zip:
		nearby_zipline = null

func start_zipline() -> void:
	is_ziplining = true
	zip_t = 0.0
	velocity = Vector3.ZERO
	zip_start_pos = nearby_zipline.zip_start.global_position
	zip_end_pos = nearby_zipline.zip_end.global_position

func zipline_process(delta):
	zip_t += ZIP_SPEED * delta
	global_position = zip_start_pos.lerp(zip_end_pos, zip_t)

	if Input.is_action_just_pressed("ui_cancel"):
		is_ziplining = false

	if zip_t >= 1.0:
		is_ziplining = false

func _physics_process(delta):
	# --- STATES FIRST: zipline takes over and skips normal movement ---
	if is_ziplining:
		zipline_process(delta)
		return

	if nearby_zipline != null and Input.is_action_just_pressed("zip"):
		start_zipline()
		return

	# --- normal movement ---
	is_sprinting = Input.is_action_pressed("sprint")
	var current_speed = SPRINT_SPEED if is_sprinting else WALK_SPEED

	var input_direction_2D = Input.get_vector(
		"moveLeft", "moveRight", "moveUp", "moveDown"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0, input_direction_2D.y
	)
	var direction = (transform.basis * input_direction_3D).normalized()

	var target_velocity_x = direction.x * current_speed
	var target_velocity_z = direction.z * current_speed

	var accel = ACCELERATION if is_on_floor() else AIR_ACCELERATION

	if direction.length() > 0.1:
		velocity.x = move_toward(velocity.x, target_velocity_x, accel * delta)
		velocity.z = move_toward(velocity.z, target_velocity_z, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		velocity.z = move_toward(velocity.z, 0, DECELERATION * delta)

	if velocity.y > 0:
		velocity.y -= GRAVITY_UP * delta
	else:
		velocity.y -= GRAVITY_DOWN * delta

	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME
	else:
		jump_buffer_timer -= delta

	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY + (SPRINT_JUMP_BONUS if is_sprinting else 0.0)
		jump_buffer_timer = 0
		coyote_timer = 0
	elif Input.is_action_just_released("jump") and velocity.y > 0:
		velocity.y *= 0.5

	move_and_slide()
