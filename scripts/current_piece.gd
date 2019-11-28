###############################
## Author : William Engel    ##
## Date Created : 2019-11-27 ##
###############################

extends Node

###############
## VARIABLES ##

export (int) var timer = 0
export (float) var speed = 1

var tick = 2
var interval = 60

var pieceT = preload("res://scenes/sub-scenes/T-Piece.tscn").instance()
var pieceL = load("res://scenes/sub-scenes/L-Piece.tscn").instance()
var pieceJ = load("res://scenes/sub-scenes/J-Piece.tscn").instance()
var pieceS = load("res://scenes/sub-scenes/S-Piece.tscn").instance()
var pieceZ = load("res://scenes/sub-scenes/Z-Piece.tscn").instance()
var pieceI = load("res://scenes/sub-scenes/I-Piece.tscn").instance()
var pieceO = load("res://scenes/sub-scenes/O-Piece.tscn").instance()

## VARIABLES ##
###############

###############
## FUNCTIONS ##



## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _enter_tree():
	add_child(pieceT)

func _ready():
	pass

func _exit_tree():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	timer += speed
	if timer == (interval * tick):
		pieceT.global_translate(Vector2(0, 32))
		timer = 0

## MAIN LOOP ##
###############