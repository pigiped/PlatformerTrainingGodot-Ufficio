extends Node

var player_pos: Vector2i = Vector2i(-31,-31)
#var player_pos: Vector2i = Vector2i(912,-31)
var checkpoint_player_pos: Vector2i = Vector2i(1100,-60)
var deaths: int = 0
var saved_score: int = 0
var saved_coins = []

func _ready() -> void:
	Engine.time_scale = 1
	SignalBus.connect("checkpoint", _on_checkpoint)
	print("game manager ready")
	

func _set_saved_coins(picked_coins: Array):
	saved_coins = picked_coins
	
func _on_checkpoint() -> void:
	_set_checkpoint()
	
func _set_checkpoint() -> void:
	player_pos = checkpoint_player_pos
	print("set checkpoint, new player respawn is: ", player_pos)

func _add_death():
	deaths += 1
	print("deaths: ", deaths)
	
func _save_score(value: int):
	saved_score = value
	print("coins saved: ", saved_score)
