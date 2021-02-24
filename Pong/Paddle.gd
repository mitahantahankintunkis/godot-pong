extends Node
# Base class for paddle controllers

const paddle_speed = 350
const damping = 0.75
var vel = Vector2()


# Moves the given node along the given direction
func move(node: KinematicBody2D, dir: Vector2):
	vel += dir * paddle_speed
	vel *= damping
	vel = vel.clamped(paddle_speed)
	vel = node.move_and_slide(vel)
