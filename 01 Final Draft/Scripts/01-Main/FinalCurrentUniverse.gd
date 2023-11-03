extends Label

func _process(delta):
	self.text = str(Global.current_universe)
