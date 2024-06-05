class_name Dealer extends Player

var publish_signal : SignalPublisher
@export var time_controller : TimeControl
func _ready():
	publish_signal = SignalPublisher.new()
	add_child(publish_signal)
	print("DEALER READY")
	pass

func reveal():
	cards.back().set_face(face_enum.FACES.FRONT)

func start_turn():
	reveal()
	while card_sum < 17:
		await time_controller.wait_for(10)
		publish_signal.all_signals.HIT.emit(self)
		pass
	pass
