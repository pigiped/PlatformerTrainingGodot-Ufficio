extends Area2D

@onready var animation_player: AnimationPlayer = $PickupSound/AnimationPlayer

func _ready() -> void:
	if(GameManager.saved_coins.has(self.name)):
		print("kys")
		queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	SignalBus.coin_picked.emit(name)
	animation_player.play("pickup")
