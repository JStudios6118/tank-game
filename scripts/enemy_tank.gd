extends CharacterBody2D

@export var speed : int
@export var turnSpeed : int
@export var body_pivot : Node2D
@export var tank_missile : PackedScene
@export var nav_agent : NavigationAgent2D
@export var barrelTurnSpeed : int

@export var barrel : Node2D

var next_waypoint: Vector2 = Vector2.ZERO
var retreat : int = 0

func _physics_process(delta):
	var target = _find_nearest()
	nav_agent.target_position = target
	
	
	var body_rot = body_pivot.rotation_degrees
	var next_pos = rad_to_deg(get_angle_to(next_waypoint))
	# Get the input direction and handle the rotation
	
	var angle_diff = wrapf(next_pos - body_rot, -180, 180)
	# Determine the rotation amount based on turn speed and delta time
	var rotation_amount = turnSpeed * delta
	
	# Rotate the barrel based on the angle difference and rotation amount
	barrel.rotation = get_angle_to(target)
	
	if target != position:
		
		if abs(angle_diff) > rotation_amount:
			body_pivot.rotation_degrees += sign(angle_diff) * turnSpeed
		else:
			body_pivot.rotation_degrees = next_pos
		
		
		velocity = Vector2(cos(body_pivot.rotation), sin(body_pivot.rotation)) * speed
		
	else:
		velocity = Vector2(0,0)
	
	
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
		
	if mindist < 99999 and mindist > 100:
		return closest
	elif mindist > 50 and retreat == 0:
		return position
	else:
		retreat = 1
		return Vector2(cos(body_pivot.rotation), sin(body_pivot.rotation)) * -100


func _on_navigation_timer_timeout():
	next_waypoint = nav_agent.get_next_path_position()


func _on_retreat_timer_timeout() -> void:
	retreat = 0
