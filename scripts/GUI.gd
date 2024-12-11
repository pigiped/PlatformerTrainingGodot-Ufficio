extends CanvasLayer
class_name UI

var score = 0
@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

func _ready() -> void:
	SignalBus.connect("coin_picked",update_score)
	SignalBus.connect("checkpoint", _on_checkpoint)
	set_score(GameManager.saved_score)
	
func _on_checkpoint() -> void:
	GameManager._save_score(score)
	
func update_score(name):
	print("updated score +1")
	score += 1
	add_coin()
	if(score == 18):
		Engine.time_scale = 0.5
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func add_coin():
	var coinTextureRec = TextureRect.new()
	coinTextureRec.texture = load("res://assets/sprites/coin_single.png")
	coinTextureRec.custom_minimum_size = Vector2(32,32)
	h_flow_container.add_child(coinTextureRec)

func set_score(value: int) -> void:
	score = value
	for n in score:
		add_coin()
