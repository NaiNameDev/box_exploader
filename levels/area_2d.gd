extends Area2D
@export var player:CharacterBody2D



func _ready():
	connect("body_entered",_on_body_entered)

func _on_body_entered(body):
	print("Игрок вошел в зону!")
	player.have_box == true
