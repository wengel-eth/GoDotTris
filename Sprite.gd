extends Sprite
extends KinematicBody2D

# Declare member variables here. Examples:
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	get_input()
	velocity = 

#
# All other functions
#

func get_input():
	velocity = Vector2()
	if Input.is_key_pressed(KEY_W):
		velocity.y += 1
	if Input.is_key_pressed(KEY_S):
		velocity.y -= 1