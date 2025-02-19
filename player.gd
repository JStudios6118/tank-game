extends CharacterBody2D

@export var speed : int = 300
@export var turnSpeed : int = 100

@export var barrelTurnSpeed : int = 100

@export var barrel : Node2D

func _physics_process(delta: float) -> void:
	var target_rotation = (get_global_mouse_position() - barrel.global_position).angle()
	
	# Calculate the difference between the current rotation and the target rotation.
	var angle_diff = target_rotation - rotation
	if angle_diff > PI:
		angle_diff -= PI * 2
	elif angle_diff < -PI:
		angle_diff += PI * 2
		
	# Gradually rotate the barrel towards the target rotation.
	barrel.rotation += angle_diff * barrelTurnSpeed * delta
	
	# Get the input direction and handle the rotation.
	var direction := Input.get_axis("left", "right")
	if direction:
		rotate(direction * turnSpeed * delta)

	if Input.is_action_pressed("forward"):
		velocity = Vector2(cos(rotation), sin(rotation)) * speed
	else:
		velocity = Vector2.ZERO

	# Move the player in the direction they are looking.
	move_and_slide()
