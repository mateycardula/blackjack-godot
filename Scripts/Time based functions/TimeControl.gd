class_name TimeControl extends SignalListener

var time : float

func wait_for(ticks : int):
	var i = 0 
	while i<ticks:
		await all_signals.TICK
		i+= 1
	return

func wait_for_random(from_ticks : int, to_ticks : int):
	await wait_for(randi_range(from_ticks, to_ticks))
