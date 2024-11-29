extends Area2D

func _on_body_entered(body: Node2D) -> void:
	SignalBus.gravity_changed.emit(Vector2i.LEFT)
