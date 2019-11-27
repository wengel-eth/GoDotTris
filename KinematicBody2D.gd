extends KinematicBody2D

export (int) var speed = 200

# Declare member variables here. Examples:
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

###############
## FUNCTIONS ##

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

## FUNCTIONS ##
###############

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
