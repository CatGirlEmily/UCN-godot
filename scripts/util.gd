extends Node

# plays sound if true, stops if false
func playWhen(node, criteria: bool):
	if criteria: node.play()
	else: node.stop()

# show() if true, hide() if false
func showWhen(node, criteria: bool):
	if criteria: node.show()
	else: node.hide()


# returns number of digits
func intGetLength(value: int): return str(value).length()
