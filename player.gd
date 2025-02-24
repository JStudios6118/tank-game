extends CharacterBody2D

@export var speed : int = 300
@export var turnSpeed : int = 100
@export var body_pivot : Node2D
@export var tank_missile : PackedScene

@export var barrelTurnSpeed : int = 100

@export var barrel : Node2D


func _physics_process(delta):
	var angle_to_mouse = rad_to_deg(get_angle_to(get_global_mouse_position()))
	var barrelRotation = barrel.rotation_degrees
	# Normalize the angle difference to be within [-180, 180]
	var angle_diff = wrapf(angle_to_mouse - barrelRotation, -180, 180)
	# Determine the rotation amount based on turn speed and delta time
	var rotation_amount = barrelTurnSpeed * delta
	
	# Rotate the barrel based on the angle difference and rotation amount
	if abs(angle_diff) > rotation_amount:
		barrel.rotation_degrees += sign(angle_diff) * (rotation_amount)
	else:
		barrel.rotation_degrees = angle_to_mouse

	
	# Get the input direction and handle the rotation.
	var direction := Input.get_axis("left", "right")
	if direction:
		body_pivot.rotate(direction * turnSpeed * delta)

	if Input.is_action_pressed("forward"):
		velocity = Vector2(cos(body_pivot.rotation), sin(body_pivot.rotation)) * speed
	else:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("shoot"):
		var temp = tank_missile.instantiate()
		temp.global_position = $BarrelEnd.global_position
		temp.global_rotation = $BarrelEnd.global_rotation
		get_tree().root.add_child(temp)


	# Move the player in the direction they are looking.
	move_and_slide()
