extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer
@export var is_wold_edge: int

func _on_body_entered(body: Node2D) -> void:
	if(is_wold_edge == 1 and player.gravityDirection == Vector2i.DOWN):
		print("you died")
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()
		GameManager._add_death()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
