extends Node

var dev_mode = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		$"../Pause Menu".hidden = !$"../Pause Menu".hidden
	
	if Input.is_action_just_pressed("Dev"):
		dev_mode = !dev_mode
	$"../Hud".offset = $"../World/Player".position
