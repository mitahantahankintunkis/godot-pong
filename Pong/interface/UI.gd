extends Control



func _on_MainGame_p1_score_update(score):
	$P1Score.text = str(score)


func _on_MainGame_p2_score_update(score):
	$P2Score.text = str(score)
