extends  CharacterBody2D
@onready var processor: Node = $"../../Processor"
@onready var grav_flip: Node2D = $"../Grav Flip"

const accel = 100
const friction = [1500, 7500]
const speed = 400

const jump_power = -1000

var dspeed = 1500
var daccel = 10000
var djump = -1500

var gravity = Vector2(0, 50)

func _physics_process(delta: float) -> void:
	if true: # Movement
		var dir = Input.get_axis("l", "r")
		if dir:
			velocity.x += dir * dev('a', int(processor.dev_mode))
			velocity.x = clamp(velocity.x, -dev('s', int(processor.dev_mode)), dev('s', int(processor.dev_mode)))
		else:
			var ufric = 0
			if is_on_floor() or processor.dev_mode:
				ufric = friction[1];
			else:
				ufric = friction[0]
			velocity.x = move_toward(velocity.x, 0.0, delta * ufric)
	
	
	if !processor.dev_mode: # Jumping and Gravity
		if !is_on_floor():
			velocity += gravity
		if Input.is_action_just_pressed("u") and (is_on_floor() or processor.dev_mode):
			velocity.y = dev('j', int(processor.dev_mode))

	else: # Dev up/down movement
		var dir = Input.get_axis("d", "u")
		if dir:
			velocity.y -= dir * dev('a', int(processor.dev_mode))
			velocity.y = clamp(velocity.y, -dev('s', int(processor.dev_mode)), dev('s', int(processor.dev_mode)))
		else:
			velocity.y = move_toward(velocity.y, 0.0, delta * friction[1])
		pass
	
	if true: # Dev Stuff
		if processor.dev_mode:
			$"../../Hud/Hud Root/Dev Mode".show()
			$Camera2D.zoom = Vector2(0.35, 0.35)
			if Input.is_action_just_pressed("Hover"):
				velocity = Vector2.ZERO
		else:
			$"../../Hud/Hud Root/Dev Mode".hide()
			$Camera2D.zoom = Vector2(1.0, 1.0)
	
	if true: # Gravity Changes
		for i: Area2D in get_tree().get_nodes_in_group("Flips"):
			if self in i.get_overlapping_bodies():
				while self in i.get_overlapping_bodies():
					if !is_on_floor():
						velocity += gravity
						move_and_slide()
				gravity *= -1
	
	move_and_slide()

func dev(n, d):
	var vars = {'s': [speed, dspeed], 'a':[accel, daccel], 'j':[jump_power, djump]}
	return vars[n][d]
