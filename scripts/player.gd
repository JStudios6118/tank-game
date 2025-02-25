extends CharacterBody2D

@export_category("Player Settings")

@export_subgroup("Speed Settings")
@export var speed : int = 100
@export var turn_speed : int = 3
@export var barrel_turn_speed : int = 100

@export_subgroup("Player Values")
@export var max_health : int = 100
@export var max_ammo : int = 10

@export_subgroup("References")
@export var body_pivot : Node2D
@export var barrel : Node2D
@export var ui_ref : PlayerUI

@export_subgroup("Scenes")
@export var tank_missile : PackedScene

var angle_to_mouse : float
var barrel_rotation : float
var angle_diff : float
var rotation_amount : float
var dir : int

var ammo : int = max_ammo

func _ready():
	ui_ref.set_ammo_bar(max_ammo)

func _physics_process(delta):
	angle_to_mouse = rad_to_deg(get_angle_to(get_global_mouse_position()))
	barrel_rotation = barrel.rotation_degrees
	# Normalize the angle difference to be within [-180, 180]
	angle_diff = wrapf(angle_to_mouse - barrel_rotation, -180, 180)
	# Determine the rotation amount based on turn speed and delta time
	rotation_amount = barrel_turn_speed * delta
	
	# Rotate the barrel based on the angle difference and rotation amount
	
	if angle_diff > 0:
		dir = 1
	else:
		dir = -1
	
	
	if abs(angle_diff) > rotation_amount:
		barrel.rotation_degrees += rotation_amount * dir
		
	else:
		barrel.rotation_degrees = angle_to_mouse
	
	
	# Get the input direction and handle the rotation.
	var direction := Input.get_axis("left", "right")
	if direction:
		body_pivot.rotate(direction * turn_speed * delta)

	if Input.is_action_pressed("forward"):
		velocity = Vector2(cos(body_pivot.rotation), sin(body_pivot.rotation)) * speed
	else:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("shoot"):
		if ammo == 0:
			return
		ammo -= 1
		ui_ref.remove_ammo()
		var temp = tank_missile.instantiate()
		temp.global_position = $BarrelPivot/BarrelEnd.global_position
		temp.global_rotation = $BarrelPivot/BarrelEnd.global_rotation
		get_tree().root.add_child(temp)


	# Move the player in the direction they are looking.
	move_and_slide()
