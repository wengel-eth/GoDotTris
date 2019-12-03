###############################
## Author : William Engel    ##
## Date Created : 2019-11-27 ##
###############################

extends Node2D

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

onready var grid = get_node(NodePath("../surroundArea/surroundUI"))
onready var area = get_node(NodePath("../surroundArea/pieceArea"))
onready var leftWall = get_node(NodePath("../surroundArea/leftWall"))
onready var rightWall = get_node(NodePath("../surroundArea/rightWall"))
onready var topWall = get_node(NodePath("../surroundArea/topWall"))
onready var bottomWall = get_node(NodePath("../surroundArea/bottomWall"))

var unit = 32
var currentPiece = null
var frameOffset = Vector2()
var frameCollision = false
var floorCollision = false
var floorTimer = 0
var floorTimerMax = 60
var hardCollision = false

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
	var ib = round(rand_range(-0.5, 6.499))
	return ib

# creates a random piece at the start
func spawnPiece():
	pieceIndex = blop()
	add_child(pieceArray[pieceIndex].duplicate())
	currentPiece = get_child(0)
	currentPiece.global_translate(Vector2(0, unit*-9))
	pieceRotation = 0
	if pieceIndex != 5 and pieceIndex != 6:
		currentPiece.global_translate(Vector2(16, 16))

# reparent a node to another node
func reparent(parent, source, target):
	parent.remove_child(source)
	target.add_child(source)
	source.set_owner(target)

# transfers each blobk to the grid
func cement(piece):
	for x in range(piece.get_child_count()):
		piece.get_child(0).set_position(piece.get_child(0).get_global_position())
		reparent(piece, piece.get_child(0), area)

# all the previous functions put together to submit the piece
func placePiece():
	reparent(self, currentPiece, area)
	cement(currentPiece)
	currentPiece.queue_free()
	spawnPiece()

## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _ready():
	spawnPiece()

func _process(delta):
	# checks if both keys are pressed and exits if they are
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		pass
	else:
		# checks if left button is pressed, moves piece left and continues if still pressed
		if Input.is_action_just_pressed("move_left"):
			for i in range(currentPiece.get_child_count()):
				if currentPiece.get_child(i).overlaps_area(leftWall):
					frameCollision = true
					break
			if frameCollision == false:
				frameOffset += Vector2(unit*-1, 0)
				leftPressed = true
			floorCollision = false
		if Input.is_action_pressed("move_left") and leftPressed:
			if leftPressedTicker == pressedTickerMax:
				if pressedTickerInterval == pressedTickerIntervalMax:
					for s in range(currentPiece.get_child_count()):
						if currentPiece.get_child(s).overlaps_area(leftWall):
							frameCollision = true
							break
					if frameCollision == false:
						frameOffset += Vector2(unit*-1, 0)
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
			for a in range(currentPiece.get_child_count()):
				if currentPiece.get_child(a).overlaps_area(rightWall):
					frameCollision = true
					break
			if frameCollision == false:
				frameOffset += Vector2(unit, 0)
				rightPressed = true
			floorCollision = false
		if Input.is_action_pressed("move_right") and rightPressed:
			if rightPressedTicker == pressedTickerMax:
				if pressedTickerInterval == pressedTickerIntervalMax:
					for r in range(currentPiece.get_child_count()):
						if currentPiece.get_child(r).overlaps_area(rightWall):
							frameCollision = true
							break
					if frameCollision == false:
						frameOffset += Vector2(unit, 0)
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
	
	# checks if space is pressed, and does a hard drop if so
	if Input.is_action_just_pressed("hard_drop"):
		placePiece()
	
	# checks for collision and moves
	for i in range(currentPiece.get_child_count()):
		if currentPiece.get_child(i).overlaps_area(bottomWall):
			floorCollision = true
		for g in range(area.get_child_count()):
			if currentPiece.get_child(i).overlaps_area(area.get_child(g)):
				floorCollision = true
	
	# gradual moving down
	timer += speed
	if timer >= (interval * tick) and floorCollision == false:
		currentPiece.global_translate(Vector2(0, unit))
		timer = 0
	if floorCollision:
		floorTimer += 1
		if floorTimer <= floorTimerMax:
			pass
		else:
			placePiece()
			floorCollision = false
			floorTimer = 0
			timer = 0
	else:
		floorTimer = 0
	
	# moves collision piece
	currentPiece.global_translate(frameOffset)
	currentPiece.set_global_rotation(deg2rad(pieceRotation))
	frameOffset = Vector2()
	frameCollision = false

## MAIN LOOP ##
###############