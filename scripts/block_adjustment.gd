###############################
## Author : William Engel    ##
## Date Created : xxxx-xx-xx ##
###############################

extends Node2D

###############
## VARIABLES ##

onready var pn = get_node(NodePath("../currentPiece"))

## VARIABLES ##
###############

###############
## FUNCTIONS ##



## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	# checks for collision and moves piece back
	for c in range(pn.currentPiece.get_child_count()):
		if pn.currentPiece.get_child(c).overlaps_area(pn.leftWall):
			pn.leftCollision = true
		if pn.currentPiece.get_child(c).overlaps_area(pn.rightWall):
			pn.rightCollision = true
		if pn.currentPiece.get_child(c).overlaps_area(pn.bottomWall):
			pn.floorCollision = true
	if pn.tempCollide:
		pn.leftCollision = false
		pn.rightCollision = false
		pn.floorCollision = false
		pn.tempCollide = false
	if pn.leftCollision:
		pn.reverseOffset += Vector2(pn.unit, 0)
		pn.tempCollide = true
	if pn.rightCollision:
		pn.reverseOffset -= Vector2(pn.unit, 0)
		pn.tempCollide = true
	if pn.floorCollision:
		pn.reverseOffset -= Vector2(0, pn.unit)
		pn.tempCollide = true
	
	# collision moves back
	pn.currentPiece.global_translate(pn.reverseOffset)
	pn.reverseOffset = Vector2()
	pn.leftCollision = false
	pn.rightCollision = false

## MAIN LOOP ##
###############
