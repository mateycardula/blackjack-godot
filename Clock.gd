class_name Clock extends Timer
	
@export var tick_publisher : SignalPublisher

func _ready():
	tick_publisher = SignalPublisher.new()
	add_child(tick_publisher)

func _on_timeout():
	tick_publisher.all_signals.TICK.emit()
	pass # Replace with function body.
