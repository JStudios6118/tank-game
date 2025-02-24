class_name PlayerUI
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	set_ammo_bar(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_ammo_bar(length):
	for x in range(length):
		var ammo_slot = TextureRect.new()
		ammo_slot.
		$AmmoBar.add_child(ammo_slot)
