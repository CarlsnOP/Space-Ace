extends PathFollow2D


@export var shoots := false
@export var aims_at_player := false
@export var bullet_scene: PackedScene
@export var bullet_damage := 10
@export var bullet_speed := 120.0
@export var bullet_direction := Vector2.DOWN
@export var bullet_wait_time := 3.0
@export var bullet_wait_time_var := 0.05

#score
@export var kill_me_score := 10
@export var damage_taken := 10

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var laser_timer = $LaserTimer
@onready var booms = $Booms
@onready var health_bar = $HealthBar


var _player_ref: Player
var _speed := 0.0
var _can_shoot := false
var _dead := false
var _anim_string: String

func _ready():
	_player_ref = get_tree().get_first_node_in_group(GameData.GROUP_PLAYER)
	if !_player_ref:
		queue_free()
	animated_sprite_2d.play(_anim_string)


func _process(delta):
	progress_ratio += _speed * delta
	
	if progress_ratio > 0.99:
		queue_free()

func setup(speed: float, anim_name: String) -> void:
	_speed = speed
	_anim_string = anim_name

func update_bullet_direction() -> void:
	if !aims_at_player or !is_instance_valid(_player_ref):
		return
	
	bullet_direction = global_position.direction_to(_player_ref.global_position)

func start_shoot_timer() -> void:
	Utils.set_and_start_timer(laser_timer, bullet_wait_time, bullet_wait_time_var)

func shoot() -> void:
	var b = bullet_scene.instantiate()
	update_bullet_direction()
	b.setup(
		global_position,
		bullet_direction,
		bullet_speed,
		bullet_damage	
	)
	get_tree().root.add_child(b)
	start_shoot_timer()

func make_booms() -> void:
	for b in booms.get_children():
		ObjectMaker.create_boom(b.global_position)

func die() -> void:
	if _dead:
		return
	_dead = true
	
	set_process(false)
	make_booms()
	ScoreManager.increment_score(kill_me_score)
	queue_free()

func _on_laser_timer_timeout():
	shoot()

func _on_visible_on_screen_notifier_2d_screen_entered():
	if shoots:
		start_shoot_timer()

func _on_visible_on_screen_notifier_2d_screen_exited():
	set_process(false)
	queue_free()

func _on_area_2d_area_entered(area):
	health_bar.take_damage(damage_taken)

func _on_health_bar_died():
	die()
