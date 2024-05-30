extends Node
@onready var mock = $CanvasLayer/box/mock
@onready var score = $CanvasLayer/score
@onready var manong = $CanvasLayer/manong
@onready var submit = $CanvasLayer/submit_button

@onready var manong_anoyed=preload("res://Asset/Sprites/Annoying Char/annoyed.png")
@onready var manong_mock=preload("res://Asset/Sprites/Annoying Char/mocking.png")
@onready var dialog = $CanvasLayer/dialog

var startMsg=[
	"Come on! Click it! that can't hurt! unless you have no guts!
	do you? w-wa-wait.. you have guts, right???",
	"You should bring a looooooots of luck and some courage to click",
	"ready? set... click!!",
	"use the submit button to tell other how \"lucky\" you are or regret it!",
	"take a risk or take a rest?",
	"tch! let see how lucky you are on your next click!",
	"HOW.MUCH.LUCK.DO.YOU. HAAAAAVVEE!!?",
	"meh, can't wait to see your face full of \"REGRETS\"",
	"certainly, you will run out of luck",
	"now, test your mere luck you have",
	"Oh Gods and Goddesses, Bless this person a lot of luck and bring him into regrets!"
	]
	
var lowBallMockMsg=[
	"I have more chance having two girlfriend than you hitting the button!
	hahahah",
	"1,2, buckle my shoe, 3,4, shut the door, 5.... oh sorry, you didnt reach five..
	kikikiki",
	"......... should I console you?",
	"MWA.HA.HA.HA.HA!
	Gods of luck betrays you!"
]

var midMockMsg=[
	"YATA! the best feeling! EVER!",
	"1,little 2, little 3, little ninja, 4, little 5, little 6, little ninja, 7, little 8, little 9, little ninja, you cant even reach ten",
	"if I find a four leaf clover, I will definitely give it to you",
	"run out of luck, eh?",
	"its better to bet in lottery than you"
]

var mockMsg=[
	"Regrets! full of REGRETS!!!",
	"I like how disapointed you are! muawahahahahah!",
	"see? if you just submit it...",
	"oh hell YEEEEESSS!!",
	"pffftt.. that is your luck?",
	"calm down, dont break your mouse! pfftt..",
	"and I know it, I know it... Hee-Hee!",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	mock.text=startMsg[randi_range(0,startMsg.size()-1)]
	Bridge.onUpdateScore.connect(Callable(self,"show_scored"))
	Bridge.onLose.connect(Callable(self,"mock_him"))
	

func show_scored():
	manong.texture=manong_anoyed
	mock.text=startMsg[randi_range(0,startMsg.size()-1)]	
	score.text=str(Bridge.getScore())

func mock_him():
	manong.texture=manong_mock
	if Bridge.getScore() < 5:
		mock.text=lowBallMockMsg[randi_range(0,lowBallMockMsg.size()-1)]
	elif Bridge.getScore() < 10:
		mock.text=midMockMsg[randi_range(0,midMockMsg.size()-1)]
	else:
		mock.text=mockMsg[randi_range(0,mockMsg.size()-1)]
	score.text='0'

func _on_submit(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				submit.self_modulate=Color.GRAY
				SubmitUIclicked()
			else:
				submit.self_modulate=Color.WHITE
	pass
	
func SubmitUIclicked():
	score.visible=false
	$CanvasLayer/submit_button.visible=false
	$CanvasLayer/dialog.visible=true
	$CanvasLayer/hiScore.visible=false
	$CanvasLayer/SubmittedScore.visible=false
	$CanvasLayer/dialog/result.text="
	Retries: "+str(Bridge.retries)+"
Current Score: "+str(Bridge.score)+"
Your High Score: "+str(Bridge.myHighScore)+"
Score to Beat: 37


*********************************
::  We didn't store your score  ::
*********************************"
	mock.text= "You've failed me! Luck is a sure great skill to help you if your life is in danger, but your greed will definitely kill you!" if Bridge.alreadyWinYetYouLose else ("Oh! Kami-sama! thanks for bringing me this such lucky person! and now we can start our journey to the west." if Bridge.score>37 else ("You've impressed me! knowing when to quit is a basic characteristic of a good leader" if Bridge.retries>20 else("Failure is Inevitable and you can blame it on our system, but quiting without doing your best? SHAME ON YOU!")))
