class_name HurtBox extends Area2D

@export var damage:float = 1.0


func _ready():
	area_entered.connect(AreaEntered)

func AreaEntered(area: Area2D) -> void:
	if area is HitBox:
		area.TakeDamage(damage)
