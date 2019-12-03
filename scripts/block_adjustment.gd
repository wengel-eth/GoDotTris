###############################
## Author : William Engel    ##
## Date Created : xxxx-xx-xx ##
###############################

extends Area2D

signal collision

###############
## VARIABLES ##

onready var pn = get_node(NodePath("/root/Node2D/currentPiece"))

## VARIABLES ##
###############

###############
## FUNCTIONS ##



## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _physics_process(delta):
	if pn.currentPiece.overlaps_area(pn.leftWall):
		pn.leftCollision = true
		emit_signal("collision")
	if pn.tempCollide:
		pn.leftCollision = false
		pn.tempCollide = false
	if pn.leftCollision:
		pn.tempCollide = true

## MAIN LOOP ##
###############
