extends ProgressBar

signal completed

func _process(delta):
	self.value += delta * 10
	
	if self.value >= 100:
		self.value = 0
		emit_signal("completed")
