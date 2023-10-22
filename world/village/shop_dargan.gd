extends Node2D

var regex = RegEx.new()

var stealth_name = "Stealth Cape"
var stealth_prices = {
	1: 30,
	2: 40,
	3: 50
}

var shoes_name = "Faster Shoes"
var shoe_prices = {
	1: 30,
	2: 40,
	3: 50
}

# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("{{.*?}}")
	Global.connect("dialog_branch_selected", branch_selected)
	pass # Replace with function body.


func _replace_vars(str: String):
	for result in regex.search_all(str):
		str = str.replace(result.get_string(), "")
	return str

func _format_item(name: String, lux: int, lvl: int):
	return "%s %s(%d Lux)" % [name, "Lvl %d " % lvl if lvl > 1 else "", lux]

func branch_selected(branch: Array):
	var canBuyShoes = PlayerAutoload.shoes_lvl < PlayerAutoload.shoes_max_lvl
	var value = branch[0]["value"]
	
	if value == "{{shop2_item1}}":
		_upgrade_stealth()
	elif value == "{{shop2_item2}}":
		_upgrade_shoes()
	elif value == "{{shop1_item1}}" && canBuyShoes:
		_upgrade_shoes()
	elif value == "{{shop1_item1}}" && !canBuyShoes:
		_upgrade_stealth()
	pass

func _upgrade_shoes():
	var shoes_lvl = PlayerAutoload.shoes_lvl+1
	if _buy_with_lux(shoe_prices[shoes_lvl], shoes_name):
		PlayerAutoload.shoes_lvl += 1

func _upgrade_stealth():
	var stealth_lvl = PlayerAutoload.stealth_lvl+1
	if _buy_with_lux(stealth_prices[stealth_lvl], stealth_name):
		PlayerAutoload.stealth_lvl += 1

func _buy_with_lux(amount: int, item_name: String):
	if PlayerAutoload.lux < amount:
		Global.DialogOverlay.show_dialog("shop_dargan_missing_lux", {
			"item": _replace_vars(item_name)
		})
		return false
	else:
		PlayerAutoload.lux -= amount
		return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	var canBuyShoes = PlayerAutoload.shoes_lvl < PlayerAutoload.shoes_max_lvl
	var canBuyStealth = PlayerAutoload.stealth_lvl < PlayerAutoload.stealth_max_lvl
	var stealth_lvl = PlayerAutoload.stealth_lvl+1
	var shoes_lvl = PlayerAutoload.shoes_lvl+1
	
	if canBuyShoes && canBuyStealth:
		Global.DialogOverlay.show_dialog("shop_dargan_buy_items_2", {
			"shop2_item1": _format_item(stealth_name, stealth_prices[stealth_lvl], stealth_lvl),
			"shop2_item2": _format_item(shoes_name, shoe_prices[shoes_lvl], shoes_lvl),
			"lux_amount": PlayerAutoload.lux,
		})
	elif canBuyShoes:
		Global.DialogOverlay.show_dialog("shop_dargan_buy_items_1", {
			"shop1_item1": _format_item(shoes_name, shoe_prices[shoes_lvl], shoes_lvl),
			"lux_amount": PlayerAutoload.lux,"text": "I've got a item that might pique your interest. Check out this beauties! \nfor the speedster in you, how about these \"Supersonic Shoes\"? They're imbued with magic to make you run faster than the wind itself. These shoes channel your energy, making your movements quicker and more agile. You'll cover ground in no time, and those pesky shadows won't stand a chance.\nBut remember, lux is a precious resource in our world, and you'll want to spend it wisely. You got only " + str(PlayerAutoload.lux) + " Lux to spend."
		})
	elif canBuyStealth:
		Global.DialogOverlay.show_dialog("shop_dargan_buy_items_1", {
			"shop1_item1": _format_item(stealth_name, stealth_prices[stealth_lvl], stealth_lvl),
			"lux_amount": PlayerAutoload.lux,
			"text": "I've got a item that might pique your interest. Check out this beauties! \nThe \"Stealth Cape.\" With this magical garment, you can move silently, evading the gaze of any lurking enemies. Sneak past them like a shadow in the night!\nBut remember, lux is a precious resource in our world, and you'll want to spend it wisely. You got only " + str(PlayerAutoload.lux) + " Lux to spend."
		})
	else:
		Global.DialogOverlay.show_dialog("shop_dargan_no_items", {
			"lux_amount": PlayerAutoload.lux,
		})
