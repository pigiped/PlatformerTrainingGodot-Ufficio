extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	print("settings")


func _on_exit_pressed() -> void:
	get_tree().quit()