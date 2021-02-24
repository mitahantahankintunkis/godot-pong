extends Control

signal reset_game

func _input(event):
	if event.is_action_pressed("pause"):
		var state = not get_tree().paused
		update_state(state)


func update_state(state):
	get_tree().paused = state
	visible = state
	


func _on_Resume_pressed():
	update_state(false)


func _on_Reset_pressed():
	update_state(false)
	emit_signal("reset_game")


func _on_Quit_pressed():
	get_tree().quit()
