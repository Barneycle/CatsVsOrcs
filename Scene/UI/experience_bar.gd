extends CanvasLayer

@export var experience_manager: Node
@onready var progress_bar = %ProgressBar

func _ready():
	progress_bar.value = 0
	experience_manager.exp_updated.connect(on_exp_updated)
	
func on_exp_updated(current_exp: float, target_exp: float):
	var percent = current_exp / target_exp
	progress_bar.value = percent
