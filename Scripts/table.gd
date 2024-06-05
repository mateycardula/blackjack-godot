class_name Table extends Node2D

@export var table_deck : Deck
@export var player : Player

func _ready():
	table_deck.deal_to(player)
	table_deck.deal_to(player)
