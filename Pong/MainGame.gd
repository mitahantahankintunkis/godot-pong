extends Node2D

signal p1_score_update(score)
signal p2_score_update(score)


var p1_score = 0
var p2_score = 0
var min_fps = 999


func _ready():
	#yield(get_tree().create_timer(1), "timeout")
	respawn()
	fps_counter()

func fps_counter():
	while true:
		yield(get_tree().create_timer(1), "timeout")
		print(min_fps)
		min_fps = 999


func _physics_process(_delta):
	var fps = Engine.get_frames_per_second()
	if min_fps > fps: min_fps = fps


func respawn():
	$Ball.position = $RespawnPoint.position
	$Ball.reset()


func _on_P1Back_body_entered(_body):
	respawn()
	p2_score += 1
	emit_signal("p2_score_update", p2_score)


func _on_P2Back_body_entered(_body):
	respawn()
	p1_score += 1
	emit_signal("p1_score_update", p1_score)


func _on_reset_game():
	respawn()
	p1_score = 0
	p2_score = 0
	emit_signal("p1_score_update", 0)
	emit_signal("p2_score_update", 0)
