class_name Deck extends Node2D

@export var card_resources : Array[CardResource]
var deck_cards : Array[Card]


func _ready():
	for card_resource in card_resources:
		for i in 4:
			create_card(card_resource, i)
	
	shuffle()
	#deck_cards.shuffle()
	#var card_node : Card
	#card_node = deck_cards.pop_back()
	#card_node.set_flipped(false)
	#add_child(card_node)
	
func create_card(card_resource : CardResource, variation : int):
	var new_card = Card.new()
	var new_card_texture : Texture = card_resource.graphics.get_frame_texture("default", variation)
	
	new_card.create(new_card_texture, card_resource.number)
	deck_cards.append(new_card)
	pass

func shuffle():
	deck_cards.shuffle()

func deal_to(object : Object):
	var card_to_deal = deck_cards.pop_back()
	card_to_deal.set_flipped(false)
	object.add_card(card_to_deal)
