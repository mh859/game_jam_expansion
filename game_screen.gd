extends Node2D
#@onready var lines_of_code = $bckground/PerformancePanel/LinesOfCode
@onready var lines_of_code = $bckground/PerformancePanel/VBoxContainer/LinesOfCode
@onready var tech_debt = $bckground/PerformancePanel/VBoxContainer/TechDebt
@onready var to_do = $bckground/PerformancePanel/VBoxContainer/ToDo
@onready var employee_morale = $bckground/PerformancePanel/VBoxContainer/EmployeeMorale
@onready var money = $bckground/PerformancePanel/VBoxContainer/Money

#buttons
@onready var new_hire = $bckground/PerformancePanel/VBoxContainer/NewHire
@onready var pizza_party = $bckground/PerformancePanel/VBoxContainer/PizzaParty
@onready var integrate_ai = $bckground/PerformancePanel/VBoxContainer/IntegrateAI

var end_game = false
var line_count = 0
var tech_debt_count = 0
var things_to_do = 0
var runway = 150000
var morale_status = "GOOD"
var workers = []
var worker_index = 0
var ai_multiplier = 1

signal tech_debt_stress
signal destress

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = get_tree().current_scene
	var children = scene.get_children()
	
	for child in children:
		if child.has_method("_on_worker_button_pressed") and child.visible:
			workers.append(child)
			#print(child)

@onready var ai_1_animation_player = $bckground/AI1/RichTextLabel/AI1AnimationPlayer
@onready var ai_2_animation_player = $bckground/AI2/RichTextLabel/AI2AnimationPlayer
@onready var ai_3_animation_player = $bckground/AI3/RichTextLabel/AI3AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end_game:
		return
	if ai_multiplier == 2:
		ai_1_animation_player.play("text")
	if ai_multiplier == 3:
		ai_2_animation_player.play("text")
	if ai_multiplier == 4:
		ai_3_animation_player.play("text")
		trigger_end()
	if tech_debt_count > 30:
		self.tech_debt_stress.emit()
	money.text = "Money: $" + str(runway) 
	#moral
	var combined_stress = 0 
	var num_of_workers = len(workers)
	for single_worker in workers:
		combined_stress += single_worker.stress
	#print(combined_stress)
	if combined_stress > num_of_workers + 2:
		morale_status = "BAD"
	elif combined_stress > num_of_workers - 2 and combined_stress < num_of_workers + 2:
		morale_status = "FAIR"
	else:
		morale_status = "GOOD" 
	employee_morale.text = "Employee Morale: " + morale_status
		
	toggle_upgrade_buttons()

#helpers
func toggle_upgrade_buttons():
	#pizza_party.disabled = true
	#integrate_ai.disabled = true
	#new_hire.disabled = true
	
	if runway >= 500:
		pizza_party.disabled = false
	else:
		pizza_party.disabled = true
	if runway >= 1000:
		integrate_ai.disabled = false
	else:
		integrate_ai.disabled = true
	if runway >= 150000 and worker_index <= 3:
		new_hire.disabled = false
	else:
		new_hire.disabled = true
@onready var ai_3 = $bckground/AI3
@onready var ui = $UI


func trigger_end():
	end_game=true
	for i in [16, 18, 19, 19, 19, 20, 20, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22]:
		#print(i)
		await get_tree().create_timer(22.0 - i).timeout
		var duplicate_node = ai_3.duplicate()
		duplicate_node.position.x += randi_range(-90, 90)
		duplicate_node.position.y += randi_range(-90, 90)
		add_child(duplicate_node)
		

	await get_tree().create_timer(5.0).timeout
	print("done")
	ui.visible = true
	
	
	
#signals
func _on_worker_finished_task():
	#lines of code
	var rand_code_count = randi_range(10,500)
	line_count += rand_code_count * self.ai_multiplier
	lines_of_code.text = "Lines Of Code: " + str(line_count)
	#tech debt
	var rand_tech_debt = randi_range(-3, 5)
	tech_debt_count += rand_tech_debt 
	tech_debt_count = max(0, tech_debt_count) * self.ai_multiplier
	tech_debt.text = "Tech Debt: " + str(tech_debt_count)
	# things to do
	if things_to_do >= 1:
		things_to_do -= 1 
		to_do.text = "Things To Do: " + str(things_to_do)
	
	#money
	runway += 100 * self.ai_multiplier
	
	
	
	


func _on_timer_timeout():
	things_to_do += 1
	to_do.text = "Things To Do: " + str(things_to_do)


func _on_pizza_party_pressed():
	self.runway -= 500
	money.text = "Money: $" + str(runway) 
	for single_worker in workers:
		single_worker.stress = 0
		single_worker.num_of_tasks = 5
		#self.destress.connect(single_worker)

func _on_worker_2_finished_task():
	_on_worker_finished_task() # Replace with function body.


func _on_worker_3_finished_task():
	_on_worker_finished_task() # Replace with function body.





func _on_worker_4_finished_task():
	_on_worker_finished_task()


func _on_worker_5_finished_task():
	_on_worker_finished_task()


func _on_worker_6_finished_task():
	_on_worker_finished_task()


func _on_worker_7_finished_task():
	_on_worker_finished_task()

func _on_new_hire_pressed():
	var index = worker_index + 4
	if index > 7:
		return
	self.runway -= 150000
	var node_name = "Worker"+str(index)
	var new_worker = get_tree().current_scene.get_node(node_name)
	new_worker.visible = true
	worker_index += 1
	
	


func _on_integrate_ai_pressed():
	self.runway -= 1000
	self.ai_multiplier += 1
	





