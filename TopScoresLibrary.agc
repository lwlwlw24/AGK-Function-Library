//***************************************
//*** Five top scores to/from file ***
//*** functions ***
//***************************************
// Wayne LIN
// 20180511
// v01
// copy from AppGameKit Official Tutorial Guide.pdf CH15

//DataType
// HighScoreType - contains name and
// 					score for one player
// Fields
// player_name 	string 	player’s name
// high_score 	integer player’s score
//
//
//Functions
// UpdateHighScoresFile(score)
// Reads high scores for game from a file
// (HighScores.dat).
// Checks if score should be added to high
// score list. If so, reads in player’s
// name and adds details to list.
// Writes updated score list back to file.

// UpdateTopScoresList(scoreslist as HighScoreType[],newscore)
// Called by UpdateHighScoresFile() to add
// new score to list and get name.

// ListHighScores()
// Lists the name and score of each entry in the
// high scores list.

//*** Define scores entry ***
type HighScoreType
	player_name as string
	high_score as integer
endtype



//*** Updates high score list in file and returns updated list ***

function UpdateHighScoresFile(score as integer)
	gamesplayed as HighScoreType[5] //Contains high score details


	//*** If high scores file exists ***
	if GetFileExists("HighScores.dat") = 1
		//*** Open file for reading ***
		fileID = OpenToRead("HighScores.dat")
		//*** Read the file’s details ***
		for c = 1 to 5
			gamesplayed[c].player_name=ReadString(fileID)
			gamesplayed[c].high_score=ReadInteger(fileID)
		next c
		
		//*** Close the file ***
		CloseFile(fileID)
	endif
	//*** If current game is in top five,add to high***
	//*** score list ***
	if UpdateTopScoresList(gamesplayed,score) = 1
		//*** Open high score file for writing ***
		fileID = OpenToWrite("HighScores.dat")
		//*** Write updated list to file ***
		for c = 1 to 5
			WriteString(fileID,gamesplayed[c].player_name)
			WriteInteger(fileID,gamesplayed[c].high_score)
		next c
		CloseFile(fileID)
	endif
endfunction gamesplayed


//*** Adds newscore to list, if newscore contains a high score **
//*** Returns 1 if added, 0 if not added ***
function UpdateTopScoresList(list ref as HighScoreType[], newscore as integer)
	//*** Find insert point ***
	post = 1
	while post < list.length and list[post].high_score > newscore
		inc post
	endwhile
	//*** If not a high score, return zero ***
	if list[post].high_score > newscore
		exitfunction 0
	endif
	//*** Free up cell ***
	for c = list.length-1 to post step -1
		list[c+1] = list[c]
	next c
	//*** Insert value ***
	list[post].high_score = newscore
	//*** Get player’s name ***
	StartTextInput("Enter name")
	SetTextInputMaxChars(12)
	while GetTextInputCompleted() = 0
		Sync()
	endwhile
	list[post].player_name = GetTextInput()
	//*** Value added to list, return 1 ***
endfunction 1

//*** Displays current top five players’ details ***
function ListHighScores()
	gamesplayed as HighScoreType[5] //Contains high score details
	//*** If high scores file exists ***
	if GetFileExists("HighScores.dat") = 1
		//*** Open file for reading ***
		fileID = OpenToRead("HighScores.dat")
		//*** Read the file’s details ***
		for c = 1 to 5
			gamesplayed[c].player_name=ReadString(fileID)
			gamesplayed[c].high_score=ReadInteger(fileID)
		next c
		//*** Close the file ***
		CloseFile(fileID)
	endif
	//*** Display the details ***
	Print("")
	Print("")
	Print("Top scores:")
	for c = 1 to 5
		PrintC(gamesplayed[c].player_name + Spaces(13-Len(gamesplayed[c].player_name)))
		Print(gamesplayed[c].high_score)
	next c
endfunction

//*** Displays the player’s score and highest ***
//*** scores over image imgname. Deletes the ***
//*** info when clicked ***

function ShowEndMessage(imgname as string, score as integer)
	top as HighScoreType[] //Contains details of top scores
	
	//*** New score not highlighted ***
	highlighted = 0
	//*** Create overlay sprite ***
	LoadImage(1,imgname)
	CreateSprite(1,1)
	SetSpriteSize(1,50,50)
	SetSpritePosition(1,25,5)
	//*** Create text resource to give result ***
	CreateText(99,Str(score))
	SetTextSize(99, 6)
	SetTextAlignment(99,1)
	SetTextPosition(99, 50, 16)
	SetTextColor(99,255,0,0,255)
	//*** Display Top scores ***
	top = UpdateHighScoresFile(game.crabs_caught)
	for c = 1 to 5
		CreateText(99+c,top[c].player_name+Spaces(13-Len(top[c].player_name))+Str(top[c].high_score))	
		SetTextColor(99+c,0,0,0,255)
		SetTextPosition(99+c,35,25+c*5)
	next c
	//*** When clicked, delete end screen details ***
	Sync()
	Sleep(4000)
	while GetPointerPressed() = 0
		Sync()
	endwhile
	//*** Delete all resources created by function ***
	for c = 0 to 5
		DeleteText(99+c)
	next c
	DeleteSprite(1)
	DeleteImage(1)
endfunction
