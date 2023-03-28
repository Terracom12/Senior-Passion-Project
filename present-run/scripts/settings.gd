extends Control

func _ready():
	$"VBoxContainer/SoundVolumeContainer/VolumeOptionSlider".value = GlobalVars.sound_volume
	$"VBoxContainer/MusicVolumeContainer/VolumeOptionSlider".value = GlobalVars.music_volume
	$"VBoxContainer/FullscreenOptionButton".pressed = OS.window_fullscreen

func _input(event):
	if(event.is_action_pressed("settings")):
		_on_SettingsButton_button_up()
		get_tree().paused = !get_tree().paused

func _on_SettingsButton_button_up():
	visible = !visible


func _on_SoundVolumeOptionSlider_value_changed(value):
	GlobalVars.sound_volume = value


func _on_MusicVolumeOptionSlider_value_changed(value):
	GlobalVars.music_volume = value


func _on_FullscreenOptionButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_CloseButton_pressed():
	visible = false
	get_tree().paused = false
