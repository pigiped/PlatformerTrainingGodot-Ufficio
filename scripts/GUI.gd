extends CanvasLayer
class_name UI

var score = 0
@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

func _ready() -> void:
	SignalBus.coin_picked.connect(update_score.bind(1))

func update_score(value):
	score += value
	add_coin()
	
func add_coin():
	var coinTextureRec = TextureRect.new()
	coinTextureRec.texture = load("res://assets/sprites/coin_single.png")
	coinTextureRec.custom_minimum_size = Vector2(32,32)
	h_flow_container.add_child(coinTextureRec)
