extends CharacterBody2D

const accel = 100
const friction = [1500, 5000]
const speed = 400

const jump_power = -1000

var dev_mode = false
var dspeed = 800
var daccel = 10000
var djump = -1500

var functions = [
	func():
		print("rocket?")
,
	func():
		if dev_mode:
			print("dev")
		else:
			print("normal")
]

func _physics_process(delta: float) -> void:
	if true: # Movement
		var dir = Input.get_axis("l", "r")
		if dir:
			var uaccel = 0;	var uspeed = 0
			if dev_mode: uaccel = daccel;uspeed = dspeed
			else: uaccel = accel; uspeed = speed
			velocity.x += dir * uaccel
			velocity.x = clamp(velocity.x, -uspeed, uspeed)
		else:
			var ufric = 0
			if is_on_floor() or dev_mode:
				ufric = friction[1];
			else:
				ufric = friction[0]
			velocity.x = move_toward(velocity.x, 0.0, delta * ufric)
	
	if true: # Jumping and Gravity
		if !is_on_floor():
			velocity.y += 50
		if Input.is_action_just_pressed("u") and (is_on_floor() or dev_mode):
			var ujump = 0
			if dev_mode: ujump=djump
			else:ujump=jump_power
			velocity.y = ujump
	
	if true:
		if Input.is_action_just_pressed("Dev"):
			dev_mode = !dev_mode
		if dev_mode:
			$"../../Hud/Hud Root/Dev Mode".show()
			$Camera2D.zoom = Vector2(0.35, 0.35)
			if Input.is_action_pressed("Hover"):
				velocity = Vector2.ZERO
		else:
			$"../../Hud/Hud Root/Dev Mode".hide()
			$Camera2D.zoom = Vector2(1.0, 1.0)
	
	move_and_slide()
