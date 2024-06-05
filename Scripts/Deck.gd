class_name Deck extends Node2D

@export var card_resources : Array[CardResource]
var deck_cards : Array[Card]
var listener : SignalListener
var dealt_cards : Array[Card]
func _ready():
	listener = SignalListener.new()
	add_child(listener)
	for card_resource in card_resources:
		for i in 4:
			create_card(card_resource, i)
	
	
func create_card(card_resource : CardResource, variation : int):
	var new_card = Card.new()
	var new_card_texture : Texture = card_resource.graphics.get_frame_texture("default", variation)
	
	new_card.create(new_card_texture, card_resource.number)
	deck_cards.append(new_card)
	pass

func shuffle():
	deck_cards.shuffle()

func deal_to(object : Player, face : face_enum.FACES):
	print("CARDS ", deck_cards.size())
	var card_to_deal = deck_cards.pop_back()
	await object.add_card(card_to_deal, face)
	dealt_cards.append(card_to_deal)
	
func take_cards():
	for card in dealt_cards:
		var new_card = Card.new()
		new_card.create(card.visible_texture, card.value)
		deck_cards.append(new_card)
		card.queue_free()
	shuffle()
	dealt_cards.clear()
