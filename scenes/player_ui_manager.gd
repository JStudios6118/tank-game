class_name PlayerUI
extends Control

@export var ammo_indicator_icon: Texture2D
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func remove_ammo():
	$AmmoBar.get_child(0).queue_free()

func set_ammo_bar(length):
	for each in $AmmoBar.get_children():
		each.queue_free()
	for x in range(length):
		var ammo_slot = TextureRect.new()
		ammo_slot.texture = ammo_indicator_icon
		$AmmoBar.add_child(ammo_slot)
