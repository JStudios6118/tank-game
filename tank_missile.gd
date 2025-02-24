extends Node2D

@export var barrel_pivot : Node2D

var speed = 1
var direction : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(direction) * speed
	position.y += sin(direction) * speed
