extends Node


enum ENEMY_TYPE { ZIPPER, BIO, BOMBER }
enum POWERUP_TYPE { HEALTH, SHIELD }


const GROUP_PLAYER := "player"
const GROUP_HOMING_MISSILE := "homing_missile"
const GROUP_SAUCER := "saucer"
const GROUP_ENEMY_SHIP := "enemy_ship"
const GROUP_BULLET := "bullet"

const MISSILE_DAMAGE := 10
const COLLISION_DAMAGE := 40

const POWER_UPS = {
	POWERUP_TYPE.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
	POWERUP_TYPE.SHIELD: preload("res://assets/misc/shield_gold.png")
}
