extends Node2D

signal check_spin

#variables handling the wheel's basic physics
var speed : float = 0.0
var max_speed : float = 3.0
var friction : float = 5.0
var strength : float = 4.0

#variables handling the way the wheel connects with the interface
var mouse_hover : bool = false
var angle : float = 0.0
var spin : int = 0

func _ready():
	pass

func _input(event: InputEvent) -> void:
	#use the clicks to increase speed
	if event.is_action_pressed("click") and mouse_hover == true:
		speed += strength
		print("speed=",speed, " angle=", angle, " spin=", spin, " strength=", strength)
	
func _physics_process(delta: float) -> void:
	var physical_speed = speed * delta
	#spin the wheel
	if speed <= max_speed:
		rotate(physical_speed)
		angle += physical_speed
	else:
		speed = max_speed
	#reduce the rotation speed
	if speed > 0:
		speed -= physical_speed * friction
	#score points
	if angle >= 6:
		angle = 0
		spin += 1
		check_spin.emit()

#check whether the mouse pointer is hovering over the wheel or not
func _on_wheel_area_mouse_entered() -> void:
	print("mouse entered")
	mouse_hover = true

func _on_wheel_area_mouse_exited() -> void:
	print("mouse exited")
	mouse_hover = false

#handling upgrades
func _on_upgrades_upgrading_str(bonus, cost) -> void:
	if spin > cost:
		strength += bonus
		spin -= cost
		check_spin.emit()


func _on_upgrades_upgrading_fct() -> void:
	if spin > 0:
		friction = friction * 0.9
		spin -= 1
		check_spin.emit()


func _on_upgrades_upgrading_mxs() -> void:
	if spin > 0:
		max_speed += 2
		spin -= 1
		check_spin.emit()
