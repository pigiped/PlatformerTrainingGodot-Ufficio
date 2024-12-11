extends Area2D

var picked_coins = []

func _ready() -> void:
	SignalBus.connect("coin_picked", record_coin_picked)

func _on_body_entered(body: Node2D) -> void:
	GameManager._set_saved_coins(picked_coins)
	SignalBus.checkpoint.emit()
	print("hitted checkpoint")
	var texture = load("res://assets/sprites/flag.png")
	get_node("Sprite2D").texture = texture
	get_node("CollisionShape2D").queue_free()

func record_coin_picked(name: String) -> void:
	picked_coins.append(name)
	print("appended: ", name)
