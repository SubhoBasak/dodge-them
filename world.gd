extends Node2D

@export var enemy_scene: PackedScene

@onready var player: Area2D = $Player as Area2D
@onready var enemies: Node2D = $Enemies as Node2D
@onready var enemy_location: PathFollow2D = $EnemyPath/EnemyPathFollow as PathFollow2D
@onready var score_board: Label = $ScoreBoard as Label
@onready var enemy_timer: Timer = $EnemyTimer as Timer
@onready var score_timer: Timer = $ScoreTimer as Timer
@onready var start_timer: Timer = $StartTimer as Timer

var score: int = 0


func _ready() -> void:
	_on_new_game()


func _on_new_game() -> void:
	score_board.text = "000000"
	start_timer.start()


func _on_player_hit() -> void:
	enemy_timer.stop()
	score_timer.stop()
	player.hide()


func _on_enemy_timer_timeout() -> void:
	var enemy: RigidBody2D = enemy_scene.instantiate() as RigidBody2D
	
	enemy_location.progress_ratio = randf()
	enemy.position = enemy_location.position
	
	var direction: float = enemy_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	var velocity: Vector2 = Vector2(randf_range(150, 250), 0)
	
	enemy.rotation = direction
	enemy.linear_velocity = velocity.rotated(direction)
	
	enemies.add_child(enemy)


func _on_score_timer_timeout() -> void:
	score += 1

	var new_score: String = str(score)
	new_score = new_score.lpad(6, "0")

	score_board.text = new_score


func _on_start_timer_timeout() -> void:
	player.show()
	enemy_timer.start()
	score_timer.start()
