###############################
## Author : William Engel    ##
## Date Created : 2019-11-27 ##
###############################

extends Node

###############
## VARIABLES ##

export (float) var speed = 1
export (int) var pressedTickerMax = 25
export (int) var pressedTickerIntervalMax = 1

var timer = 0
var tick = 2
var interval = 60

var pieceT = load("res://scenes/sub-scenes/T-Piece.tscn").instance()
var pieceL = load("res://scenes/sub-scenes/L-Piece.tscn").instance()
var pieceJ = load("res://scenes/sub-scenes/J-Piece.tscn").instance()
var pieceS = load("res://scenes/sub-scenes/S-Piece.tscn").instance()
var pieceZ = load("res://scenes/sub-scenes/Z-Piece.tscn").instance()
var pieceI = load("res://scenes/sub-scenes/I-Piece.tscn").instance()
var pieceO = load("res://scenes/sub-scenes/O-Piece.tscn").instance()

var pieceArray = [pieceT, pieceL, pieceJ, pieceS, pieceZ, pieceI, pieceO]
var pieceIndex = null
var pieceRotation = 0

var leftPressed = false
var leftPressedTicker = 0
var rightPressed = false
var rightPressedTicker = 0
var pressedTickerInterval = 0

## VARIABLES ##
###############

###############
## FUNCTIONS ##

# gets a random float between 0 and 6 and rounds to a whole number
func blop():
	randomize()
	var ib = round(rand_range(0, 6))
	return ib

## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _enter_tree():
	# creates a random piece at the start
	pieceIndex = blop()
	add_child(pieceArray[pieceIndex].duplicate())

func _exit_tree():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	# checks if both keys are pressed and exits if they are
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		pass
	else:
		# checks if left button is pressed, moves piece left and continues if still pressed
		if Input.is_action_just_pressed("move_left"):
			get_child(0).global_translate(Vector2(-32, 0))
			leftPressed = true
		if Input.is_action_pressed("move_left") and leftPressed:
			if leftPressedTicker == pressedTickerMax:
				if pressedTickerInterval == pressedTickerIntervalMax:
					get_child(0).global_translate(Vector2(-32, 0))
					pressedTickerInterval = 0
				else:
					pressedTickerInterval += 1
			else:
				leftPressedTicker += 1
		if Input.is_action_just_released("move_left"):
			leftPressed = false
			leftPressedTicker = 0
			pressedTickerInterval = 0
		
		# checks if right button is pressed, moves piece right and continues if still pressed
		if Input.is_action_just_pressed("move_right"):
			get_child(0).global_translate(Vector2(32, 0))
			rightPressed = true
		if Input.is_action_pressed("move_right") and rightPressed:
			if rightPressedTicker == pressedTickerMax:
				if pressedTickerInterval == pressedTickerIntervalMax:
					get_child(0).global_translate(Vector2(32, 0))
					pressedTickerInterval = 0
				else:
					pressedTickerInterval += 1
			else:
				rightPressedTicker += 1
		if Input.is_action_just_released("move_left"):
			rightPressed = false
			rightPressedTicker = 0
			pressedTickerInterval = 0
	
	# checks if both rotation keys are pressed and exits if they are
	if Input.is_action_pressed("rotate_left") and Input.is_action_pressed("rotate_right"):
		pass
	else:
		# checks if left button was pressed and rotates if true
		if Input.is_action_just_pressed("rotate_left"):
			pieceRotation -= 90
		
		# gets if right button was pressed and rotates if true
		if Input.is_action_just_pressed("rotate_right"):
			pieceRotation += 90
		
		get_child(0).set_global_rotation(deg2rad(pieceRotation))
	
	timer += speed
	if timer == (interval * tick):
		get_child(0).global_translate(Vector2(0, 32))
		timer = 0

## MAIN LOOP ##
###############