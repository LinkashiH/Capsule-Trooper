extends Resource

class_name Weapon

@export_category("Weapon")
@export var weapon_name : String
@export var shoot_anim : String
@export var aim_shoot_anim : String
@export var reload_anim : String
@export var ammo_out_anim : String
@export var current_ammo : int
@export var reserve_ammo : int
@export var magazine : int
@export var max_ammo : int 
@export var auto_fire : bool

@export_flags("HitScan","Projectile") var type
