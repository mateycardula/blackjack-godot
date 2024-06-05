class_name Player extends Node2D

@export var card_positions : Array[Marker2D]
var card_sum : int = 0
var dealt_cards : int = 0

func add_card(card : Card):
	if(dealt_cards<2):
		card.position = card_positions[dealt_cards].position
		add_child(card)
		print("ADDED CARD", card)
		dealt_cards+=1
	pass
