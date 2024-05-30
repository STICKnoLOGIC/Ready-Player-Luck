extends Node

signal onUpdateScore
signal onLose

var score:int=0
var retries:=0
var myHighScore=0
var alreadyWinYetYouLose=false

func scored():
	score+=1
	if myHighScore<score:
		myHighScore=score
	if alreadyWinYetYouLose:
		alreadyWinYetYouLose= myHighScore < score
	onUpdateScore.emit()

func getScore():
	return score

func lost():
	if !alreadyWinYetYouLose:
		alreadyWinYetYouLose= score>=37
	onLose.emit()
	score=0
	retries+=1
