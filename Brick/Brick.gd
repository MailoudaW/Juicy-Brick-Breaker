extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(224,49,49,255)
	elif score >= 90:
		$ColorRect.color = Color8(253,126,20,255)
	elif score >= 80:
		$ColorRect.color = Color8(255,212,30,255)
	elif score >= 70:
		$ColorRect.color = Color8(143,216,40,255)
	elif score >= 60:
		$ColorRect.color = Color8(35,138,240,255)
	elif score >= 50:
		$ColorRect.color = Color8(133,76,219,255)
	else:
		$ColorRect.color = Color8(134,142,150,255)


func _physics_process(_delta):
	if dying and not $Confetti.emitting:
		queue_free()

func hit(_ball):
	die()

func die():
	dying = true
	collision_layer = 0
	$Confetti.emitting = true
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
