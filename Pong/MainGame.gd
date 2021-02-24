extends Node2D

signal p1_score_update(score)
signal p2_score_update(score)

var p1_score = 0
var p2_score = 0


func _ready():
	respawn()


# Resets the ball
func respawn():
	$Ball.position = $RespawnPoint.position
	$Ball.reset()


# Resets the ball and updates scoring
func _on_P1Back_body_entered(_body):
	respawn()
	p2_score += 1
	emit_signal("p2_score_update", p2_score)


# Resets the ball and updates scoring
func _on_P2Back_body_entered(_body):
	respawn()
	p1_score += 1
	emit_signal("p1_score_update", p1_score)


# Resets the ball and resets scores
func _on_reset_game():
	respawn()
	p1_score = 0
	p2_score = 0
	emit_signal("p1_score_update", 0)
	emit_signal("p2_score_update", 0)
