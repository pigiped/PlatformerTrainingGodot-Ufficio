extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("changeGravity"):
		body.changeGravity(Vector2i.DOWN)
		print("going down")
	
	
