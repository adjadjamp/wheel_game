extends Control

@onready var str_button = $upgrade_strength
@onready var frc_button = $reduce_friction

@onready var str_counter = 1:
	set(value):
		str_counter = clamp(value, 1, _arraycount(strboard))
@onready var fct_counter = 1:
	set(value):
		fct_counter = clamp(value, 1, _arraycount(fctboard))

signal upgrading_str
signal upgrading_fct

var strboard = {
	1 : {"cost": 1, "bonus": 1},
	2 : {"cost": 2, "bonus": 0.5},
	3 : {"cost": 4, "bonus": 0.5},
}

var fctboard = {
	1 : {"cost": 1, "bonus": 0.1},
	2 : {"cost": 2, "bonus": 0.05},
	3 : {"cost": 4, "bonus": 0.05},
}

func _arraycount(Array):
	var counter = 0
	for element in Array:
		counter += 1
	return counter

func _ready():
	frc_button.text = "Reduce friction by 0.1 for 1 spin"
	str_button.text = "Upgrade strength by 1 for 1 spin"

func _on_upgrade_strength_pressed() -> void:
	var cost = strboard[str_counter]["cost"]
	var bonus = strboard[str_counter]["bonus"]
	str_counter += 1
	print("bought strength upgrade of ",bonus," for a cost of ", cost)
	upgrading_str.emit(bonus,cost)

func _on_reduce_friction_pressed() -> void:
	var cost = strboard[fct_counter]["cost"]
	var bonus = strboard[fct_counter]["bonus"]
	fct_counter += 1
	print("bought friction upgrade of ",bonus," for a cost of ", cost)
	upgrading_fct.emit(bonus,cost)
