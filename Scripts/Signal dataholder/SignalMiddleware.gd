class_name SignalMiddleware extends Node

@onready var all_signals : SignalDataHolder = find_signal_controller(self, "SignalDataHolder") 
@onready var parent = get_parent() 

func find_signal_controller(node, controller_name):
	var parent = node.get_parent()
	while(parent.get_parent() != null):
		parent = parent.get_parent()
	return parent.get_child(0).find_child(controller_name)

