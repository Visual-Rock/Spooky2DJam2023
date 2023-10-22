extends Node

signal finished_init()
signal dialog_branch_selected(dict: Dictionary)

var DialogOverlay : CanvasLayer

var inited : bool = false

func init():
	if !inited:
		DialogOverlay = load("res://dialog_overlay.tscn").instantiate()
		get_parent().add_child.call_deferred(DialogOverlay)
		DialogOverlay.connect("branch_selected", branch_selected)
		
		var audio = AudioStreamPlayer.new()
		audio.stream = AudioStreamOggVorbis.load_from_file("res://assets/sounds/music.ogg")
		audio.autoplay = true
		audio.volume_db -= 30
		# get_parent().add_child.call_deferred(audio)
		inited = true

func branch_selected(dict):
	emit_signal("dialog_branch_selected", dict)
