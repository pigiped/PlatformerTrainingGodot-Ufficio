extends Area2D

@onready var animation_player: AnimationPlayer = $PickupSound/AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	SignalBus.coin_picked.emit(name)
	animation_player.play("pickup")
