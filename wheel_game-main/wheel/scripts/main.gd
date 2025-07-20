extends Node2D

@onready var counter = get_node("spins_count")
@onready var wheel = get_node("wheel")
var spincount : int = 0

func _ready() -> void:
	counter.text = str("Current spins = ") + str(spincount)

func _process(delta: float) -> void:
	pass

func _on_wheel_check_spin() -> void:
	spincount = wheel.spin
	counter.text = str("Current spins = ") + str(spincount)
