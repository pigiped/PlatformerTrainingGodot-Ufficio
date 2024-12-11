extends Area2D


func _on_body_entered(body: Node2D) -> void:
	SignalBus.checkpoint.emit()
	GameManager._set_checkpoint()
	print("hitted checkpoint")
	var texture = load("res://assets/sprites/flag.png")
	get_node("Sprite2D").texture = texture
	get_node("CollisionShape2D").queue_free()
