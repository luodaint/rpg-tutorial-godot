class_name HitBox extends Area2D

signal Damaged( damage: float)

func TakeDamage(damage: float) -> void:
	print("TakeDamage: ",  damage)
	Damaged.emit(damage)
