extends Node2D

signal check_spin

#variables handling the wheel's basic physics
var speed : float = 0.0:
	set(value):
		speed = clamp(value, 0, INF)
var strength : float = 6.0
var fct_fluid : float = 15.0
var fct_solid : float = 15.0

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
		print("speed=",speed, " angle=", angle, " spin=", spin, " strength=", strength," fct_fluid=", fct_fluid)
	
func _physics_process(delta: float) -> void:
	var physical_speed = speed * delta
	#spin the wheel
	rotate(physical_speed)
	angle += physical_speed
	#reduce the rotation speed
	speed -= delta * (fct_fluid * speed + fct_solid)
	#score points
	if angle >= TAU:
		var bonus: int = angle / TAU
		spin += bonus
		angle -= bonus * TAU
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
	if spin >= cost and cost > 0:
		strength += bonus
		spin -= cost
		check_spin.emit()


func _on_upgrades_upgrading_fct(bonus, cost) -> void:
	if spin >= cost and cost > 0:
		fct_fluid = fct_fluid * (1-bonus)
		spin -= cost
		check_spin.emit()
