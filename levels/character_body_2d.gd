extends CharacterBody2D

# Скорость движения персонажа в пикселях в секунду
@export var speed: int = 300
var have_box = false 

func _physics_process(delta):
  # Получаем input vector (ввод игрока)

  var direction: Vector2 = Input.get_vector("left","right","up","down")

  # Рассчитываем новую скорость
  velocity = direction * speed
  
  # Применяем движение и обрабатываем столкновения
  move_and_slide()
