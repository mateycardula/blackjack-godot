class_name Table extends Node2D

@export var table_deck : Deck
@export var player : RegularPlayer
@export var dealer : Dealer

@export var time_control : TimeControl

var listener : SignalListener
var publish_signal : SignalPublisher

func _ready():
	publish_signal = SignalPublisher.new()
	listener = SignalListener.new()
	add_child(listener)
	add_child(publish_signal)
	listener.subscribe(hit, listener.all_signals.HIT)
	listener.subscribe(player_drew_over_21, listener.all_signals.PLAYER_DREW_OVER_21)
	listener.subscribe(start_dealer_turn, listener.all_signals.DEALER_TURN)
	
	start_round()
	
func hit(player : Player):
	table_deck.deal_to(player, face_enum.FACES.FRONT)
	pass


func start_dealer_turn():
	await dealer.start_turn()
	print("ROUND FINISHED")
	await time_control.wait_for(10)
	start_round()
	pass

func player_drew_over_21():
	dealer.reveal()
	await time_control.wait_for(10)
	table_deck.take_cards()

func start_round():
	table_deck.take_cards()
	player.reset()
	dealer.reset()
	publish_signal.all_signals.LOCK_INPUT.emit(true)
	await time_control.wait_for(10)
	table_deck.deal_to(player, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(dealer, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(player, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(dealer, face_enum.FACES.BACK)
	publish_signal.all_signals.LOCK_INPUT.emit(false)
	pass
