extends CharacterBody2D

@export var move_speed: int = 150
@export var zombie_damage: int = 10
@export var attack_range: float = 50.0
@export var attack_cooldown: float = 1.0

var player: Node2D
var can_attack: bool = true
var zombie_health: int = 100

func _ready():
	# Находим игрока автоматически
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if not player or not is_instance_valid(player):
		return
	
	# Простое преследование игрока (без навигации)
	var direction = (player.global_position - global_position).normalized()
	
	# Движение к игроку
	velocity = direction * move_speed
	
	# Поворот в сторону игрока
	if direction.length() > 0.1:
		rotation = direction.angle()
	
	move_and_slide()
	
	# Проверка атаки
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player <= attack_range and can_attack:
		attack_player()

func attack_player():
	if can_attack and player.has_method("take_damage"):
		player.take_damage(zombie_damage)
		can_attack = false
		
		# Кд перед следующей атакой
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true

func take_zombie_damage(amount: int):
	zombie_health -= amount
	if zombie_health <= 0:
		zombie_die()

func zombie_die():
	# Эффекты смерти, анимация, дроп лута
	queue_free()
