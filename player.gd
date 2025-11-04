extends Area2D

signal hit

@export_group("Player")
@export var speed: int = 500

@onready var player_image: AnimatedSprite2D = $PlayerImage as AnimatedSprite2D

var screen_size: Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	).normalized()

	position += direction * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if direction.length() > 0:
		player_image.play()
	else:
		player_image.stop()

	if direction.x != 0:
		player_image.animation = "walk"
		player_image.flip_h = direction.x < 0
		player_image.flip_v = false
	elif direction.y != 0:
		player_image.animation = "up"
		player_image.flip_v = direction.y > 0
		player_image.flip_h = false


func _on_body_entered(_body: Node2D) -> void:
	hit.emit()
