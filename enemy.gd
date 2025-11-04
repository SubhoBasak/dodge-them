extends RigidBody2D

const animation_names: Array[String] = ["fly", "swim", "walk"]

@onready var animation_image: AnimatedSprite2D = $EnemyImage as AnimatedSprite2D


func _ready() -> void:
	animation_image.animation = animation_names.pick_random()
	animation_image.play()


func _on_enemy_notifier_screen_exited() -> void:
	queue_free()
