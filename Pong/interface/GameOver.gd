extends Control

signal reset_game()


func _on_Button_pressed():
	emit_signal("reset_game")
