extends CharacterBody2D

@export var speed : int = 10
@export var turnSpeed : int = 1
@export var body_pivot : Node2D
@export var tank_missile : PackedScene
@export var nav_agent : NavigationAgent2D
@export var barrelTurnSpeed : int = 100

@export var barrel : Node2D



func _physics_process(delta):
	var target = _find_nearest()
	nav_agent.target_position = target
	var angle_to_mouse = rad_to_deg(get_angle_to(nav_agent.get_next_path_position()))
	var barrelRotation = barrel.rotation_degrees
	# Normalize the angle difference to be within [-180, 180]
	var angle_diff = wrapf(angle_to_mouse - barrelRotation, -180, 180)
	# Determine the rotation amount based on turn speed and delta time
	var rotation_amount = barrelTurnSpeed * delta
	
	# Rotate the barrel based on the angle difference and rotation amount
	#if abs(angle_diff) > rotation_amount:
		#barrel.rotation_degrees += sign(angle_diff) * (rotation_amount)
	#else:
		#barrel.rotation_degrees = angle_to_mouse
	
	barrel.rotation_degrees = rad_to_deg(get_angle_to(nav_agent.get_next_path_position()))
	
	# Get the input direction and handle the rotation.
	var direction
	print(str(rad_to_deg(get_angle_to(nav_agent.get_next_path_position())) - body_pivot.rotation_degrees))
	if rad_to_deg(get_angle_to(nav_agent.get_next_path_position())) - body_pivot.rotation_degrees > 0:
		direction = 1
	else:
		direction = -1
	if direction:
		body_pivot.rotate(direction * turnSpeed * delta)
	
	
	velocity = Vector2(cos(body_pivot.rotation), sin(body_pivot.rotation)) * speed
	
	
	if Input.is_action_just_pressed("shoot"):
		var temp = tank_missile.instantiate()
		temp.global_position = $BarrelPivot/BarrelEnd.global_position
		temp.global_rotation = $BarrelPivot/BarrelEnd.global_rotation
		get_tree().root.add_child(temp)
	
	
	# Move the player in the direction they are looking.
	move_and_slide()



func _find_nearest():
	var dist
	var current
	var closest
	var mindist = 99999
	
	
	
	for i in get_tree().get_nodes_in_group("players"):
		current = i.position
		dist = global_position.distance_to(current)
		if dist < mindist:
			mindist = dist
			closest = current
		
	if mindist != 99999:
		return closest
