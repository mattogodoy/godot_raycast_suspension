extends Node

# Suspension
@export var suspension_rest_dist: float = 0.5 # Spring length
@export var spring_strength: float = 10 # Stiffness of suspension
@export var spring_damper: float = 1 # Force that stabilyzes suspension
@export var wheel_radius:float = 0.33

@export var debug: bool = false
@export var engine_power: float = 2

@export var steering_angle: float = 30.0
@export var front_tire_grip: float = 2.0
@export var rear_tire_grip: float = 2.0

@onready var fl_wheel = $Wheels/FL_Wheel
@onready var fr_wheel = $Wheels/FR_Wheel


var accel_input
var steering_input

func _process(delta):
	accel_input = Input.get_axis("ui_up", "ui_down")
	steering_input = Input.get_axis("ui_right", "ui_left")
	
	var steering_rotation = steering_input * steering_angle
	
	if steering_rotation != 0:
		var angle = clamp(fl_wheel.rotation.y + steering_rotation, -steering_angle, steering_angle)
		var new_rotation = angle * delta
		
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, new_rotation, 0.3)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, new_rotation, 0.3)
	else:
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, 0.0, 0.2)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, 0.0, 0.2)
