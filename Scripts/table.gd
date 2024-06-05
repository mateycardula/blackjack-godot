class_name Table extends Node2D

@export var table_deck : Deck
@export var player : RegularPlayer
@export var dealer : Dealer

@export var time_control : TimeControl
@export var buttons : VBoxContainer
@export var announce_label : Label

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
	lock_player_input(true)
	await dealer.start_turn()
	print("ROUND FINISHED")
	start_round()
	

func player_drew_over_21(score:int):
	if(score==21):
		print("BLACKJACK")
		start_dealer_turn()
	else:
		await dealer.reveal()
		start_round()

func start_round():
	calculate()
	lock_player_input(true)
	await wait_for_start_input()
	reset_table()
	await initial_deal()	
	lock_player_input(false)
	

func reset_table():
	table_deck.take_cards()
	player.reset()
	dealer.reset()

func wait_for_start_input():
	buttons.visible = true
	await listener.all_signals.START
	buttons.visible = false
	
func _on_start_pressed():
	publish_signal.all_signals.START.emit()
	pass # Replace with function body.

func initial_deal():
	await time_control.wait_for(10)
	table_deck.deal_to(player, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(dealer, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(player, face_enum.FACES.FRONT)
	await time_control.wait_for(10)
	table_deck.deal_to(dealer, face_enum.FACES.BACK)

func calculate():
	if(player.card_sum == 0):
		announce(states_enum.STATES.GOOD_LUCK)
		return
	if(dealer.card_sum>21):
		announce(states_enum.STATES.VICTORY)
		return
	if(player.card_sum == dealer.card_sum):
		announce(states_enum.STATES.DRAW)
		return
	if(player.card_sum>21):
		announce(states_enum.STATES.LOSE)
		return
		
	if(player.card_sum == 21):
		announce(states_enum.STATES.BLACKJACK)
		return
	if(dealer.card_sum > player.card_sum):
		announce(states_enum.STATES.LOSE)
		return
		
	announce(states_enum.STATES.ERROR)



func lock_player_input(flag : bool):
	publish_signal.all_signals.LOCK_INPUT.emit(flag)
	
func announce(state : states_enum.STATES):
	
	match state:
		states_enum.STATES.VICTORY:
			#announce_label.text = "You won"
			announce_label.draw_announcement("You won", Color.LAWN_GREEN)
		states_enum.STATES.DRAW:
			#announce_label.text = "Draw"
			announce_label.draw_announcement("Draw", Color.ORANGE)
		states_enum.STATES.BLACKJACK:
			#announce_label.text = "Blackjack!"
			announce_label.draw_announcement("Blackjack!", Color.GOLD)
		states_enum.STATES.GOOD_LUCK:
			#announce_label.text = "Good luck"
			announce_label.draw_announcement("Good luck!", Color.LAWN_GREEN)
		states_enum.STATES.LOSE:
			announce_label.draw_announcement("YOU LOST", Color.CRIMSON)
		_: 
			announce_label.draw_announcement("ERROR :(", Color.CRIMSON)
