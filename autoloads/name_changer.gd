extends Node

var michaels: Array[String] = [
	"michael",
	"micheal",
	"mikel",
	"michl",
	"mitchl",
	"mikeal",
	"mikale",
	"mikael",
	"miceal",
	"miguel",
	"mikuel",
	"morical",
	"mario",
	"marchicle"
]

func _ready() -> void:
	var window := get_window()
	while true:
		window.title = michaels.pick_random() + "s mansion"
		await get_tree().create_timer(5).timeout
