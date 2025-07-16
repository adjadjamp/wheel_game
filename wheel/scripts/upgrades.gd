extends Control

signal upgrading_str
signal upgrading_mxs
signal upgrading_fct
signal upgrading_pts

func _ready():
	pass


func _on_upgrade_max_speed_pressed() -> void:
	upgrading_mxs.emit()

func _on_reduce_friction_pressed() -> void:
	upgrading_fct.emit()

func _on_upgrade_strength_pressed() -> void:
	upgrading_str.emit(4,1)
	print("strup")
