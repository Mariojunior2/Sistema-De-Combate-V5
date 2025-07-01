extends Node2D

const SPEED := 300
var shooter: CharacterBody2D = null
var has_hit := false  # Garante dano único

func _ready():
	$DamageArea.connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_area_entered(area: Area2D) -> void:
	if has_hit: 
		return  # Evita múltiplos hits
	
	var enemy = area.get_owner()
	
	if enemy == null or enemy == self:
		return

	if enemy.is_in_group("enemy") and enemy.has_method("take_damage"):
		has_hit = true
		enemy.take_damage(shooter, self)
		print("Bala acertou: ", enemy.name)
		queue_free()  # Destroi após 1 hit
