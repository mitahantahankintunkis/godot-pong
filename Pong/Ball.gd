extends KinematicBody2D

const start_speed = 200
var speed = start_speed
var vel = Vector2()


func _ready():
	randomize()
	reset()


func reset():
	speed = start_speed
	
	vel = Vector2(
		rand_range(0.50, 1.0) * (1.0 if randi() % 2 else -1.0),
		rand_range(-1.0, 1.0)
	).normalized() * speed


func _physics_process(delta):
	vel = vel.normalized() * speed
	
	var collision = move_and_collide(vel * delta)
	if collision:
		vel = vel.bounce(collision.normal)
		vel += collision.collider_velocity
		
		if collision.collider is KinematicBody2D:
			speed += 25
		
		# Limiting speed in case the ball gets stuck between a wall and the paddle
		if speed > 1000: speed = 1000
