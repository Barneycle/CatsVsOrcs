extends CanvasLayer

func _ready():
	get_tree().paused = true
	$%Restart.pressed.connect(on_restart_button_pressed)
	$%Quit.pressed.connect(on_quit_button_pressed)

func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescLabel.text = "You lost!"

func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/Game/main.tscn")
	
func on_quit_button_pressed():
	get_tree().quit()
