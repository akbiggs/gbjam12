class_name Stats

@export var vig = 1
@export var man = 1
@export var end = 1
@export var str = 1
@export var dex = 1
@export var arc = 1
@export var luk = 1

func get_hp():
	return 40 + vig * 8

func get_mp():
	return 24 + man * 8

func get_stamina():
	return 80 + end * 2

func get_equip_load():
	return 40 + end * 1.5
