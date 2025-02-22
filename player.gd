extends CharacterBody2D

@export var speed : int = 300
@export var turnSpeed : int = 100

@export var barrelTurnSpeed : int = 100

@export var barrel : Node2D

var turning: String = "No"

func _physics_process(delta):
	var angle_to_mouse = rad_to_deg(get_angle_to(get_global_mouse_position()))
	var barrelRotation = barrel.rotation_degrees
	# Normalize the angle difference to be within [-180, 180]
	var angle_diff = wrapf(angle_to_mouse - barrelRotation, -180, 180)
	# Determine the rotation amount based on turn speed and delta time
	var rotation_amount = barrelTurnSpeed * delta
	#helow wrodsl
	# Rotate the barrel based on the angle difference and rotation amount
	if abs(angle_diff) > rotation_amount:
		var turnExtra: int = 0
		if turning == "Left":
			turnExtra+=barrelTurnSpeed
		elif turning == "Right":
			turnExtra-=barrelTurnSpeed
		barrel.rotation_degrees += sign(angle_diff) * (rotation_amount+turnExtra)
	else:
		barrel.rotation_degrees = angle_to_mouse

	
	# Get the input direction and handle the rotation.
	var direction := Input.get_axis("left", "right")
	if direction:
		if direction < 0:
			turning = "Left"
		else:
			turning = "Right"
		rotate(direction * turnSpeed * delta)
	else:
		turning = "No"

	if Input.is_action_pressed("forward"):
		velocity = Vector2(cos(rotation), sin(rotation)) * speed
	else:
		velocity = Vector2.ZERO

	# Move the player in the direction they are looking.
	move_and_slide()
