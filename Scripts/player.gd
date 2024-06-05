class_name Player extends Node2D

var cards : Array[Card]
var card_sum : int = 0:
	set(value):
		card_sum = value
		score.text = "%d" % [card_sum]

var card_positions : Array[Marker2D]
var dealt_cards : int = 0


@onready var score : Label = find_child("Score")


@export var test : int

func _ready():
	score = find_child("Score")
	card_positions.append(find_child("Card 1 Position")) 
	card_positions.append(find_child("Card 2 Position")) 

func add_score(card : Card):
	if(card.value == 1):
		if card_sum + 10 > 21:
			card_sum+=1
			return
		card_sum+=10
	else:
		card_sum+=card.value
	pass

func add_card(card : Card, face : face_enum.FACES):
	place_card(card, face)
	pass

func place_card(card : Card, face : face_enum.FACES):
	cards.append(card)
	add_child(card)
	card.set_face(face)
	arrange_cards()
	
func arrange_cards():
	var total_width = (cards.size()-1) * 120
	var starting = -total_width/2
	var step = 0
	for card in cards:
		card.position.x = starting + step
		step+= 120

func reset():
	cards.clear()
	card_sum = 0
