extends CharacterBody2D

# Скорость движения персонажа в пикселях в секунду
@export var speed: int = 300

func _physics_process(delta):
  # Получаем input vector (ввод игрока)
  var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  
  # Рассчитываем новую скорость
  velocity = direction * speed
  
  # Применяем движение и обрабатываем столкновения
  move_and_slide()
