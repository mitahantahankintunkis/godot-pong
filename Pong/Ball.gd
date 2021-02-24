extends KinematicBody2D

const start_speed = 200
var speed = start_speed
var vel = Vector2()


func _ready():
	randomize()
	reset()


# Resets the ball's position, speed, and direction
func reset():
	speed = start_speed
	
	vel = Vector2(
		rand_range(0.50, 1.0) * (1.0 if randi() % 2 else -1.0),
		rand_range(-1.0, 1.0)
	).normalized() * speed


func _physics_process(delta):
	vel = vel.normalized() * speed
	
	# Reflects off of collided surfaces
	var collision = move_and_collide(vel * delta)
	if collision:
		vel = vel.bounce(collision.normal)
		vel += collision.collider_velocity
		vel = vel.normalized()
		
		# Limits velocity along the Y-axis to reduce waiting
		vel.y = clamp(vel.y, -0.8, 0.8)
		vel = vel.normalized()

		# Increases the ball speed if it hit a paddle
		if collision.collider is KinematicBody2D:
			speed += 25

		# Limits speed in case the ball gets stuck between a wall and the paddle
		if speed > 1000: speed = 1000
