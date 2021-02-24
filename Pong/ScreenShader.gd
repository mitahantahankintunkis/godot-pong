extends CanvasLayer

# Enabling shaders only during runtime for editor performance
func _ready():
	for child in get_children():
		child.visible = true
