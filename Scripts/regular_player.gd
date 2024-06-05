class_name RegularPlayer extends Player

var publish_signal : SignalPublisher
var signal_listener : SignalListener
@export var input_buttons : Array[Button]

func _ready():
	publish_signal = SignalPublisher.new()
	signal_listener = SignalListener.new()
	add_child(signal_listener)
	add_child(publish_signal)
	
	signal_listener.subscribe(lock_input, signal_listener.all_signals.LOCK_INPUT)

func add_score(card : Card):
	if(card.value == 1):
		if card_sum + 10 > 21:
			card_sum+=1
			return
		card_sum+=10
	else:
		card_sum+=card.value
	
	if(card_sum >= 21):
		publish_signal.all_signals.PLAYER_DREW_OVER_21.emit(card_sum)
	pass

func lock_input(flag : bool):
	for button in input_buttons:
		button.visible = not flag

func _on_stand_pressed():
	publish_signal.all_signals.DEALER_TURN.emit()
	pass # Replace with function body.
	
func _on_hit_pressed():
	publish_signal.all_signals.HIT.emit(self)
	pass # Rplace with function body.
