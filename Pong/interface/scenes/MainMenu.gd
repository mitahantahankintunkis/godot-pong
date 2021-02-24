extends Control

func _ready():
	get_tree().paused = true


func _on_Button_pressed():
	get_tree().paused = false
	visible = false


func _on_Button2_pressed():
	get_tree().quit()
