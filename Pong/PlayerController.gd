extends "res://Paddle.gd"

# Moves the paddle based on user input
func _physics_process(_delta):
	var dir = Vector2(
		0,
		Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up")
	).normalized()

	move(get_parent(), dir)
