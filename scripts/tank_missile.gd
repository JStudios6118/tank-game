extends Node2D

@export var barrel_pivot : Node2D

var speed = 250
var direction : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(direction) * speed * delta
	position.y += sin(direction) * speed * delta


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("walls"):
		queue_free()
