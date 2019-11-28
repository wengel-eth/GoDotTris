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

var pieceT = load("res://scenes/sub-scenes/T-Piece.tscn").instance()
var pieceL = load("res://scenes/sub-scenes/L-Piece.tscn").instance()
var pieceJ = load("res://scenes/sub-scenes/J-Piece.tscn").instance()
var pieceS = load("res://scenes/sub-scenes/S-Piece.tscn").instance()
var pieceZ = load("res://scenes/sub-scenes/Z-Piece.tscn").instance()
var pieceI = load("res://scenes/sub-scenes/I-Piece.tscn").instance()
var pieceO = load("res://scenes/sub-scenes/O-Piece.tscn").instance()

var pieceArray = [pieceT, pieceL, pieceJ, pieceS, pieceZ, pieceI, pieceO]
var pieceIndex = null

## VARIABLES ##
###############

###############
## FUNCTIONS ##

func blop():
	randomize()
	var ib = round(rand_range(0, 6))
	return ib

func id():
	randomize()
	var id = round(rand_range(100, 999))
	return id

## FUNCTIONS ##
###############

###############
## MAIN LOOP ##

func _enter_tree():
	pieceIndex = blop()
	add_child(pieceArray[pieceIndex].duplicate())

func _ready():
	pass

func _exit_tree():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("move_left"):
		get_child(0).global_translate(Vector2(-32, 0))
	if Input.is_action_just_pressed("move_right"):
		get_child(0).global_translate(Vector2(32, 0))
	
	timer += speed
	if timer == (interval * tick):
		get_child(0).global_translate(Vector2(0, 32))
		timer = 0

## MAIN LOOP ##
###############