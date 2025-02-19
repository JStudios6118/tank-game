extends CharacterBody2D

@export var speed : int = 300
@export var turnSpeed : int = 100

func _physics_process(delta: float) -> void:
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
