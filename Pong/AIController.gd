extends "res://Paddle.gd"

onready var ball = get_node("../../Ball")
onready var parent = get_parent()
onready var start_pos = parent.position

# Variables used to determine where the ball can exist during the game.
# TODO - calculate during runtime
const play_area = Vector2(560, 464 - 16)
const play_area_offset = Vector2(0, 16)


# Naive AI
func _naive():
	var dir_y
	
	if ball.vel.x < 0:
		# Idling near the center
		dir_y = start_pos.y - parent.position.y
	else:
		# Moving towards the ball
		dir_y = ball.position.y - parent.position.y
	
	var dir = Vector2(0, dir_y)

	move(parent, dir)


# Smart AI
func _smart():
	var dir_y
	
	if ball.vel.x < 0:
		# Idling near the center
		dir_y = start_pos.y - parent.position.y
	else:
		var ball_pos = ball.position - play_area_offset

		# Distance to paddle
		var dist_x = play_area.x - ball_pos.x

		# Distance the ball will travel
		var ball_dist = dist_x / cos(ball.vel.angle())

		# Where the ball will hit the paddle if there were no walls
		var hit_pos = ball_dist * ball.vel.normalized() + ball_pos

		# How many times the ball will bounce
		var bounces = int(floor(hit_pos.y / play_area.y))

		# Adding walls
		hit_pos.y = fmod(fmod(hit_pos.y, play_area.y) + play_area.y, play_area.y)
		
		# Mirroring the hit position depending on the number of bounces
		if ((bounces % 2) + 2) % 2:
			hit_pos.y = play_area.y - hit_pos.y
		
		dir_y = (hit_pos.y + play_area_offset.y) - parent.position.y

	# Reducing bouncing
	if abs(dir_y) < 32:
		dir_y = 0

	# Sending the ball in a random direction
	if parent.position.x - ball.position.x < 24:
		dir_y = rand_range(-1, 1)

	var dir = Vector2(0, dir_y)

	move(parent, dir)


func _physics_process(_delta):
	_smart()
