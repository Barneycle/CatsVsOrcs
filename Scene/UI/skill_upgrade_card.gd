extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var desc_label: Label = $%DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)
	

func set_skill_upgrade(upgrade: SkillUpgrade):
	name_label.text = upgrade.name
	desc_label.text = upgrade.description

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
