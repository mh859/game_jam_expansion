extends CharacterBody2D
@onready var task_queue = $TaskQueue
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var text_animation_player = $RichTextLabel/TextAnimationPlayer


var stress = 0 #animation indicators?
var num_of_tasks = 0 #have animation speed based off num of tasks
var speed = 3 # time it takes to complete task, tech debt makes slower
signal finished_task
var destressing_state = false




func _on_worker_button_pressed():
	self.num_of_tasks += 1
	task_queue.text = "Task Queue: " + str(self.num_of_tasks)



func _process(delta):
	task_queue.text = "Task Queue: " + str(self.num_of_tasks)
	#animated text
	if self.num_of_tasks >=1:
		text_animation_player.play("text")
	else:
		text_animation_player.stop()
	# Stress
	if destressing_state:
		self.stress -= 5
		self.stress = max(0, self.stress)
		destressing_state = false
	if self.num_of_tasks > 5:
		self.stress += .005
		self.stress = min(8, self.stress)
		animated_sprite_2d.speed_scale = self.stress
	else:
		self.stress -= .01
		self.stress = max(0, self.stress)
		animated_sprite_2d.speed_scale = 1
		


func _on_timer_timeout():
	#self.num_of_tasks -= 1
	if self.num_of_tasks >= 1:
		self.num_of_tasks -= 1
		task_queue.text = "Task Queue: " + str(self.num_of_tasks)
		self.finished_task.emit() 
	else:
		pass
	#task_queue.text = "Task Queue: " + str(self.num_of_tasks)
	


func _on_game_screen_tech_debt_stress():
	self.speed +=1
	#timer.wait_time = self.speed


	
	#self.stress -= 5
	#self.stress = max(0, self.stress)
	#self.num_of_tasks = 0
