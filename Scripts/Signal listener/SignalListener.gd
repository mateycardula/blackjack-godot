class_name SignalListener extends SignalMiddleware

func subscribe(callable : Callable, signal_to : Signal):
	signal_to.connect(callable)
	pass


