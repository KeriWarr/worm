%%%%% CREATED BY KERI WARR
%%%%% STARTED ON JANUARY 14 2011
%%%%% COMPLETED ON JANUary 26 2011
%%%%%
%%%%% WORM IS A RELATIVELY SIMPLE GAME DESIGNED TO BE CHALLENGING AND ENTERTAINING
%%%%% AT THE SAME TIME. WORM WILL TEST REFLEXES AND WILL PROVIDE PLEASANT
%%%%% GRAPHICS AND AN OPTIONAL SOUNDTRACK. IT WILL ALSO BE POSSIBLE TO
%%%%% PLAY WITH TWO OR FOUR PLAYERS AT A TIME.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GLOBAL%VARIABLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var numplayers : int := 2   % Number of players in each round
var x1, x2, x3, x4 : int   % Players locations on the x-axis
var y1, y2, y3, y4 : int   % Players locations on the y-axis
var clr1, clr2, clr3, clr4 : int   % Variable to represent the current colour of the player
var dir1, dir2, dir3, dir4 : int   % Players currnet direction (up, down, left, right)
var flag1, flag2, flag3, flag4 : int := 0   % Variable used to determine who has lost
var done1, done2 : int := 0   % Variable used to help assign points
var score1, score2, score3, score4 : int := 0   % Players scores

var chars : array char of boolean   % Used to process key commands
var ch : char   % Used to return to the main menu
var x, y, b : int   % Used for the mousewhere function
var destination : int := 0   % Navigating the menu
var audioon : int := 1   % Turning sound on/off
var audiob : int := 0   % Used to detect when the mouse button has been released
var loadchar : string := " %"   % for the loading screen

var picID1 : int := Pic.FileNew ("arrowkeys 1.jpg")   % JPG pictures imported into the game
var picID2 : int := Pic.FileNew ("arrowkeys 2.jpg")
%var picID3 : int := Pic.FileNew ("arrowkeys 3.jpg")
%var picID4 : int := Pic.FileNew ("arrowkeys 4.jpg")
var picID5 : int := Pic.FileNew ("explosion1.jpg")
var picID6 : int := Pic.FileNew ("explosion2.jpg")
%var picID7 : int := Pic.FileNew ("audioon.jpg")
%var picID8 : int := Pic.FileNew ("audiooff.jpg")

var width1 : int := Pic.Width (picID1)   % Variables used to center the pictures
var height1 : int := Pic.Height (picID1)
var width2 : int := Pic.Width (picID2)
var height2 : int := Pic.Height (picID2)
%var width3 : int := Pic.Width (picID3)
%var height3 : int := Pic.Height (picID3)
%var width4 : int := Pic.Width (picID4)
%var height4 : int := Pic.Height (picID4)
var width5 : int := Pic.Width (picID5)
var height5 : int := Pic.Height (picID5)
var width6 : int := Pic.Width (picID6)
var height6 : int := Pic.Height (picID6)
%var width7 : int := Pic.Width (picID7)
%var height7 : int := Pic.Height (picID7)
%var width8 : int := Pic.Width (picID8)
%var height8 : int := Pic.Height (picID8)


var font1 : int := Font.New ("Gill Sans MT:16:bold")   % Variables used to make certain sizes of fonts
var font2 : int := Font.New ("Gill Sans MT:22:bold")
var font3 : int := Font.New ("Gill Sans MT:44:bold")
var font4 : int := Font.New ("Gill Sans MT:66:bold")

const title1 := "WORM"   % Vairables containing the text for some titles in the program
const title2 := "Player 1"
const title3 := "Player 2"
const title4 := "Player 3"
const title5 := "Player 4"
const title6 := "Press enter to continue..."
const title7 := "Options"
const title8 := "Instructions"
const title9 := "Press 'Y' to return to the main menu"
const title10 := "Number of Players"
const title11 := "Audio"
const title12 := "Press space to return to the main menu"
const title13 := "Press any key to continue"
const title14 := "Press any key to return to the main menu"
const title15 := "Loading..."

var twidth1 : int := Font.Width (title1, font4)   % Used to center the titles
var twidth2 : int := Font.Width (title2, font2)
var twidth3 : int := Font.Width (title3, font2)
var twidth4 : int := Font.Width (title4, font2)
var twidth5 : int := Font.Width (title5, font2)
var twidth6 : int := Font.Width (title6, font2)
var twidth7 : int := Font.Width (title7, font2)
var twidth8 : int := Font.Width (title8, font2)
var twidth9 : int := Font.Width (title9, font1)
var twidth10 : int := Font.Width (title10, font2)
var twidth11 : int := Font.Width (title11, font2)
var twidth12 : int := Font.Width (title12, font1)
var twidth13 : int := Font.Width (title13, font1)
var twidth14 : int := Font.Width (title14, font1)
var twidth15 : int := Font.Width (title15, font2)
var loadwidth : int

var taken : array 0 .. 99, 0 .. 99 of boolean   % Array to represent which "squares" on the grid are occupied
						% (player will crash when they drive into an occupied square)

var leave : boolean := false   % Used to return to the main menu
var complete : boolean := false   % For ending the audio track


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PROCEDURES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

procedure border (clra : int, clrb : int, a1 : int, a2 : int, b1 : int, b2 : int, off : int)
    % This procudure is capable of drawing borders consisting
    % of small squares of any colour anywhere of the screen.

    var clr : int := 0   

    for e : a1 .. a2
	clr := Rand.Int (clra, clrb)
	Draw.FillBox (e * 6 + off, b1 * 6 + off, e * 6 + 4 + off, b1 * 6 + 4 + off, clr)
	Draw.FillBox (e * 6 + off, b2 * 6 + off, e * 6 + 4 + off, b2 * 6 + 4 + off, clr)

    end for

    for f : b1 .. b2

	clr := Rand.Int (clra, clrb)
	Draw.FillBox (a2 * 6 + off, f * 6 + off, a2 * 6 + 4 + off, f * 6 + 4 + off, clr)
	Draw.FillBox (a1 * 6 + off, f * 6 + off, a1 * 6 + 4 + off, f * 6 + 4 + off, clr)

    end for

end border

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

process pin
    % Plays music

    delay (3000)

    loop

	if audioon = 1 then

	    Music.PlayFile ("Pinball.mp3")

	end if

	exit when complete

    end loop

end pin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

process endpin
    % Stops music

    loop

	if audioon = 0 then

	    Music.PlayFileStop

	end if

	exit when complete

    end loop

end endpin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN%PROGRAM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INTRO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setscreen ("graphics:603;603,offscreenonly,nocursor,nobuttonbar")
colorback (black)
cls   % Sets the size of the screen, the background colour and a few other small things

Font.Draw (title1, (maxx div 2) - (twidth1 div 2), 492, font4, 46)

Font.Draw (title15, (maxx div 2) - (twidth15 div 2), 320, font2, 48)

Draw.Box (maxx div 2 - 103, 263, maxx div 2 + 104, 283, 71)

delay (500)

for a : 0 .. 100   % This is for drawing the loading bar

    cls

    delay (20)

    Font.Draw (title1, (maxx div 2) - (twidth1 div 2), 492, font4, 46)

    Font.Draw (title15, (maxx div 2) - (twidth15 div 2), 320, font2, 48)

    Draw.Box (maxx div 2 - 103, 263, maxx div 2 + 104, 283, 71)

    Draw.FillBox (maxx div 2 - 100, 278, maxx div 2 + a * 2 - 100, 280, 71)
    Draw.FillBox (maxx div 2 - 100, 275, maxx div 2 + a * 2 - 100, 277, 46)
    Draw.FillBox (maxx div 2 - 100, 272, maxx div 2 + a * 2 - 100, 274, 47)
    Draw.FillBox (maxx div 2 - 100, 269, maxx div 2 + a * 2 - 100, 271, 46)
    Draw.FillBox (maxx div 2 - 100, 266, maxx div 2 + a * 2 - 100, 268, 120)
    Draw.FillBox (maxx div 2 - 100 + 1, 278, maxx div 2 + a * 2 - 100 + 1, 280, 71)
    Draw.FillBox (maxx div 2 - 100 + 1, 275, maxx div 2 + a * 2 - 100 + 1, 277, 46)
    Draw.FillBox (maxx div 2 - 100 + 1, 272, maxx div 2 + a * 2 - 100 + 1, 274, 47)
    Draw.FillBox (maxx div 2 - 100 + 1, 269, maxx div 2 + a * 2 - 100 + 1, 271, 46)
    Draw.FillBox (maxx div 2 - 100 + 1, 266, maxx div 2 + a * 2 - 100 + 1, 268, 120)

    loadwidth := Font.Width (intstr (a) + loadchar, font1)
    Font.Draw (intstr (a) + loadchar, (maxx div 2) - (loadwidth div 2), 230, font1, 51)

    View.Update

end for

Font.Draw (title13, (maxx div 2) - (twidth13 div 2), 24, font1, 47)

View.Update

Input.Pause

cls


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MENU%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%fork pin
%fork endpin

loop    % Main menu loop

    score1 := 0
    score2 := 0
    score3 := 0
    score4 := 0

    border (1, 5, 0, 99, 0, 99, 2)

    Font.Draw (title1, (maxx div 2) - (twidth1 div 2), 492, font4, 46)   % This draws everything on the menu page

    border (16, 31, 12, 45, 64, 76, 2)
    Font.Draw (title7, (maxx div 2) - (twidth7 div 2) - 128, 416, font2, 51)
    Draw.FillBox ((maxx div 2) - (twidth7 div 2) - 125, 410, (maxx div 2) - (twidth7 div 2) - 108, 412, 51)

    border (16, 31, 54, 87, 64, 76, 3)
    Font.Draw (title8, (maxx div 2) - (twidth8 div 2) + 128, 416, font2, 51)
    Draw.FillBox ((maxx div 2) + (twidth8 div 2) - 34, 410, (maxx div 2) + (twidth8 div 2) - 27, 412, 51)

    Pic.Draw (picID1, maxx div 2 - (width1 div 2) - 125, 230, picCopy)
    Font.Draw (title2, (maxx div 2) - (twidth2 div 2) - 125, 330, font2, 50)
    border (41, 44, 15, 42, 36, 60, 2)

    Pic.Draw (picID2, maxx div 2 - (width2 div 2) + 125, 230, picCopy)
    Font.Draw (title3, (maxx div 2) - (twidth3 div 2) + 125, 330, font2, 50)
    border (37, 40, 57, 84, 36, 60, 3)

    %Pic.Draw (picID3, maxx div 2 - (width3 div 2) - 125, 70, picCopy)
    Font.Draw (title4, (maxx div 2) - (twidth4 div 2) - 125, 170, font2, 50)
    border (46, 50, 15, 42, 9, 33, 2)

    %Pic.Draw (picID4, maxx div 2 - (width4 div 2) + 125, 70, picCopy)
    Font.Draw (title5, (maxx div 2) - (twidth5 div 2) + 125, 170, font2, 50)
    border (52, 55, 57, 84, 9, 33, 3)

    Font.Draw (title6, (maxx div 2) - (twidth6 div 2) + 8, 24, font2, 47)

    Font.Draw ("QUIT", 508, 547, font1, 40)
    Draw.FillBox (510, 541, 523, 543, 40)
    Draw.FillBox (510, 544, 525, 544, 7)
    Draw.FillBox (523, 545, 528, 545, 7)
    border (39, 41, 83, 95, 89, 95, 0)

    View.Update

    destination := 0

    loop  % This senses the location of the mouse and when it clicks

	Input.KeyDown (chars)
	mousewhere (x, y, b)

	if x > 71 and x < 275 and y > 383 and y < 461 and b = 1 then

	    destination := 1
	    audiob := 1

	elsif x > 323 and x < 527 and y > 383 and y < 461 and b = 1 then

	    destination := 2
	    audiob := 1

	elsif x > 497 and x < 569 and y > 534 and y < 575 and b = 1 then

	    destination := 3

	end if

	if audiob = 1 then

	    loop

		mousewhere (x, y, b)
		exit when b = 0

	    end loop

	    audiob := 0

	end if

	if chars ('o') then  % This recieves commands from the keyboard to go to certain pages from the menu

	    destination := 1   % Go to the options page

	elsif chars ('i') then

	    destination := 2   % Go to the instructions page

	elsif chars ('q') then

	    destination := 3   % Quit the game

	end if

	exit when chars (KEY_ENTER) or destination not= 0   % Starts the game

    end loop 

    if destination = 3 then

	exit

    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OPTIONS%PAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if destination = 1 then
	% This draws the options page and controls the buttons on that page
    
	cls
	border (1, 5, 0, 99, 0, 99, 2)   
	Font.Draw (title7, (maxx div 2) - (twidth7 div 2), 530, font2, 51)
	Font.Draw (title10, (maxx div 2) - (twidth10 div 2), 480, font2, 49)
	border (41, 44, 32, 47, 55, 70, 1)
	Font.Draw ("2", 224, 358, font3, 42)
	border (52, 55, 52, 67, 55, 70, 1)
	Font.Draw ("4", 342, 358, font3, 53)

	if numplayers = 2 then
	
	    Draw.FillBox (200, 310, 281, 316, 42)
	    
	elsif numplayers = 4 then
	
	    Draw.FillBox (320, 310, 401, 316, 53)
	    
	end if
	
	Font.Draw (title11, (maxx div 2) - (twidth11 div 2), 260, font2, 49)
	
	if audioon = 1 then
	
	    border (47, 48, 38, 61, 11, 34, 1)
	    %Pic.Draw (picID7, maxx div 2 - (width7 div 2), 102, picCopy)
	    
	elsif audioon = 0 then
	
	    border (39, 41, 38, 61, 11, 34, 1)
	    %Pic.Draw (picID8, maxx div 2 - (width8 div 2), 102, picCopy)
	    
	end if
	
	Font.Draw (title12, (maxx div 2) - (twidth12 div 2), 24, font1, 47)
	View.Update

	loop

	    Input.KeyDown (chars)
	    mousewhere (x, y, b)

	    if x > 191 and x < 283 and y > 330 and y < 420 and b = 1 then

		audiob := 1   % Number of players buttons
		numplayers := 2
		border (41, 44, 32, 47, 55, 70, 1)
		Draw.FillBox (320, 310, 401, 316, 7)
		Draw.FillBox (200, 310, 281, 316, 42)
		View.Update

	    elsif x > 311 and x < 403 and y > 330 and y < 420 and b = 1 then

		audiob := 1
		numplayers := 4
		border (52, 55, 52, 67, 55, 70, 1)
		Draw.FillBox (200, 310, 281, 316, 7)
		Draw.FillBox (320, 310, 401, 316, 53)
		View.Update

	    elsif x > 227 and x < 371 and y > 66 and y < 209 and b = 1 then

		if audioon = 1 then  % Audio button

		    audioon := 0
		    audiob := 1
		    Draw.FillBox (maxx div 2 - 40, 100, maxx div 2 + 40, 180, 7)
		    border (39, 41, 38, 61, 11, 34, 1)
		    %Pic.Draw (picID8, maxx div 2 - (width8 div 2), 102, picCopy)
		    View.Update

		elsif audioon = 0 then

		    audioon := 1
		    audiob := 1
		    Draw.FillBox (maxx div 2 - 40, 100, maxx div 2 + 40, 180, 7)
		    border (47, 48, 38, 61, 11, 34, 1)
		    %Pic.Draw (picID7, maxx div 2 - (width7 div 2), 102, picCopy)
		    View.Update

		end if

	    end if

	    if audiob = 1 then

		loop

		    mousewhere (x, y, b)   % Gets the current location of the mouse
		    exit when b = 0

		end loop

		audiob := 0

	    end if

	    exit when chars (' ')   % Leaves when the space button is pressed

	end loop

	cls

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INSTRUCTIONS%PAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elsif destination = 2 then
	% This draws the instructions page
	
	cls
	border (1, 5, 0, 99, 0, 99, 2)
	Font.Draw (title8, (maxx div 2) - (twidth8 div 2), 530, font2, 51)

	Pic.Draw (picID1, maxx div 2 - (width1 div 2) - 125, 230, picCopy)
	Font.Draw (title2, (maxx div 2) - (twidth2 div 2) - 125, 330, font2, 50)
	border (41, 44, 15, 42, 36, 60, 2)

	Pic.Draw (picID2, maxx div 2 - (width2 div 2) + 125, 230, picCopy)
	Font.Draw (title3, (maxx div 2) - (twidth3 div 2) + 125, 330, font2, 50)
	border (37, 40, 57, 84, 36, 60, 3)

	%Pic.Draw (picID3, maxx div 2 - (width3 div 2) - 125, 70, picCopy)
	Font.Draw (title4, (maxx div 2) - (twidth4 div 2) - 125, 170, font2, 50)
	border (46, 50, 15, 42, 9, 33, 2)

	%Pic.Draw (picID4, maxx div 2 - (width4 div 2) + 125, 70, picCopy)
	Font.Draw (title5, (maxx div 2) - (twidth5 div 2) + 125, 170, font2, 50)
	border (52, 55, 57, 84, 9, 33, 3)

	Font.Draw (title13, (maxx div 2) - (twidth13 div 2), 24, font1, 47)

	Font.Draw ("Worm is a fun, simple and interactive game", 50, 490, font1, 47)
	Font.Draw ("designed to challenging and enjoyable at the same", 50, 460, font1, 47)
	Font.Draw ("time as being aesthetically pleasing.", 50, 430, font1, 47)
	Font.Draw ("These are the controls:", 50, 390, font1, 47)

	View.Update

	Input.Pause

	cls

	border (1, 5, 0, 99, 0, 99, 2)
	Font.Draw (title8, (maxx div 2) - (twidth8 div 2), 530, font2, 51)

	Font.Draw (title14, (maxx div 2) - (twidth14 div 2), 24, font1, 47)

	Font.Draw ("The objective of the game is to survive.", 50, 480, font1, 47)
	Font.Draw ("As you drive across the screen with the arrow keys", 50, 450, font1, 47)
	Font.Draw ("you will leave behind a trail of blocks.", 50, 420, font1, 47)
	Font.Draw ("When players (including yourself) drive into ", 50, 390, font1, 47)
	Font.Draw ("these blocks, they will explode.", 50, 360, font1, 47)
	Font.Draw ("Each round ends when there is only one player left.", 50, 330, font1, 47)
	Font.Draw ("The longer you survuve without crashing,", 50, 300, font1, 47)
	Font.Draw ("The more points you will accumulate.", 50, 270, font1, 47)
	Font.Draw ("collect the most points to win!", 50, 240, font1, 47)
	Font.Draw ("Good Luck!", 150, 210, font1, 47)


	View.Update

	Input.Pause

	cls

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN%LOOP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elsif destination = 0 then
	% Runs the game

	loop


	    x1 := 302
	    y1 := 302   % Sets starting locations for each player
	    x2 := 296
	    y2 := 296
	    x3 := 296
	    y3 := 302
	    x4 := 302
	    y4 := 296

	    for c : 0 .. 99
		for d : 0 .. 99   % Sets all the squares on the screen as 'untaken'
				  % (players will not crash)
		    taken (c, d) := false

		end for
	    end for

	    for a : 0 .. 99

		taken (0, a) := true   % Sets the borders as 'taken'
		taken (99, a) := true  % (players will crash upon contact)
		taken (a, 0) := true
		taken (a, 99) := true

	    end for

	    dir1 := 1  % Sets starting directions
	    dir2 := 2
	    dir3 := 3
	    dir4 := 4

	    for decreasing e : 15 .. 0   % Draws the intro to each round

		delay (28)
		cls

		for f : 0 .. e

		    for g : 0 .. e

			clr1 := Rand.Int (41, 44) 
			clr2 := Rand.Int (37, 40)
			clr3 := Rand.Int (46, 50)
			clr4 := Rand.Int (52, 55)

			Draw.FillBox (x1 + (g * 6), y1 + (f * 6), x1 + 4 + (g * 6), y1 + 4 + (f * 6), clr1)
			Draw.FillBox (x2 - (g * 6), y2 - (f * 6), x2 + 4 - (g * 6), y2 + 4 - (f * 6), clr2)

			if numplayers = 2 then

			    Draw.FillBox (x3 - (g * 6), y3 + (f * 6), x3 + 4 - (g * 6), y3 + 4 + (f * 6), clr1)
			    Draw.FillBox (x4 + (g * 6), y4 - (f * 6), x4 + 4 + (g * 6), y4 + 4 - (f * 6), clr2)

			end if

			if numplayers = 4 then

			    Draw.FillBox (x3 - (g * 6), y3 + (f * 6), x3 + 4 - (g * 6), y3 + 4 + (f * 6), clr3)
			    Draw.FillBox (x4 + (g * 6), y4 - (f * 6), x4 + 4 + (g * 6), y4 + 4 - (f * 6), clr4)

			end if

		    end for

		end for

		border (1, 5, 0, 99, 0, 99, 2)

		View.Update

	    end for

	    Draw.FillBox (x1, y1, x1 + 4, y1 + 4, 41)
	    Draw.FillBox (x2, y2, x2 + 4, y2 + 4, 37)

	    if numplayers = 4 then

		Draw.FillBox (x3, y3, x3 + 4, y3 + 4, 46)
		Draw.FillBox (x4, y4, x4 + 4, y4 + 4, 52)

	    end if

	    View.Update


	    flag1 := 0  % Sets everyone to 'not dead'
	    flag2 := 0
	    flag3 := 0
	    flag4 := 0
	    done1 := 0
	    done2 := 0

	    loop  

		taken ((x1 - 2) div 6, (y1 - 2) div 6) := true   % sets the players locations as 'taken'
		taken ((x2 - 2) div 6, (y2 - 2) div 6) := true   % (players will crash pon contact)

		if numplayers = 4 then

		    taken ((x3 - 2) div 6, (y3 - 2) div 6) := true
		    taken ((x4 - 2) div 6, (y4 - 2) div 6) := true

		end if

		clr1 := Rand.Int (41, 44)  % Randomizes the players colours
		clr2 := Rand.Int (37, 40)
		clr3 := Rand.Int (46, 50)
		clr4 := Rand.Int (52, 55)

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		Input.KeyDown (chars)   % Detects keyboard strokes

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		if flag1 not= 1 then     % Next ~230 lines for detecting the keyboard strokes, and drawing the players
		    % Player 1's controls
		    
		    if chars (KEY_UP_ARROW) and dir1 not= 2 then   % "If up arrow is pressed and direction is not already 'down'"

			dir1 := 1   % Sets direction
			y1 := y1 + 6   % Changes X/Y coordinate
			Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)   % Draws box which represents the character

		    elsif chars (KEY_DOWN_ARROW) and dir1 not= 1 then

			dir1 := 2
			y1 := y1 - 6
			Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

		    elsif chars (KEY_LEFT_ARROW) and dir1 not= 4 then

			dir1 := 3
			x1 := x1 - 6
			Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

		    elsif chars (KEY_RIGHT_ARROW) and dir1 not= 3 then

			dir1 := 4
			x1 := x1 + 6
			Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

		    else

			if dir1 = 1 and dir1 not= 2 then

			    y1 := y1 + 6
			    Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

			elsif dir1 = 2 and dir1 not= 1 then

			    y1 := y1 - 6
			    Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

			elsif dir1 = 3 and dir1 not= 4 then

			    x1 := x1 - 6
			    Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

			elsif dir1 = 4 and dir1 not= 3 then

			    x1 := x1 + 6
			    Draw.FillBox (x1, y1, x1 + 4, y1 + 4, clr1)

			end if

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		if flag2 not= 1 then
		    % Player 2's controls

		    if chars ('w') and dir2 not= 2 then

			dir2 := 1
			y2 := y2 + 6
			Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

		    elsif chars ('s') and dir2 not= 1 then

			dir2 := 2
			y2 := y2 - 6
			Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

		    elsif chars ('a') and dir2 not= 4 then

			dir2 := 3
			x2 := x2 - 6
			Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

		    elsif chars ('d') and dir2 not= 3 then

			dir2 := 4
			x2 := x2 + 6
			Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

		    else

			if dir2 = 1 and dir2 not= 2 then

			    y2 := y2 + 6
			    Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

			elsif dir2 = 2 and dir2 not= 1 then

			    y2 := y2 - 6
			    Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

			elsif dir2 = 3 and dir2 not= 4 then

			    x2 := x2 - 6
			    Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

			elsif dir2 = 4 and dir2 not= 3 then

			    x2 := x2 + 6
			    Draw.FillBox (x2, y2, x2 + 4, y2 + 4, clr2)

			end if

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				    
		if numplayers = 4 then

		    if flag3 not= 1 then
			% Player 3's controls
			
			if chars ('i') and dir3 not= 2 then

			    dir3 := 1
			    y3 := y3 + 6
			    Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			elsif chars ('k') and dir3 not= 1 then

			    dir3 := 2
			    y3 := y3 - 6
			    Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			elsif chars ('j') and dir3 not= 4 then

			    dir3 := 3
			    x3 := x3 - 6
			    Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			elsif chars ('l') and dir3 not= 3 then

			    dir3 := 4
			    x3 := x3 + 6
			    Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			else

			    if dir3 = 1 and dir3 not= 2 then

				y3 := y3 + 6
				Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			    elsif dir3 = 2 and dir3 not= 1 then

				y3 := y3 - 6
				Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			    elsif dir3 = 3 and dir3 not= 4 then

				x3 := x3 - 6
				Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			    elsif dir3 = 4 and dir3 not= 3 then

				x3 := x3 + 6
				Draw.FillBox (x3, y3, x3 + 4, y3 + 4, clr3)

			    end if

			end if

		    end if

		    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		    if flag4 not= 1 then
			% Player 4's controls

			if chars ('8') and dir4 not= 2 then

			    dir4 := 1
			    y4 := y4 + 6
			    Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			elsif chars ('5') and dir4 not= 1 then

			    dir4 := 2
			    y4 := y4 - 6
			    Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			elsif chars ('4') and dir4 not= 4 then

			    dir4 := 3
			    x4 := x4 - 6
			    Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			elsif chars ('6') and dir4 not= 3 then

			    dir4 := 4
			    x4 := x4 + 6
			    Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			else

			    if dir4 = 1 and dir4 not= 2 then

				y4 := y4 + 6
				Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			    elsif dir4 = 2 and dir4 not= 1 then

				y4 := y4 - 6
				Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			    elsif dir4 = 3 and dir4 not= 4 then

				x4 := x4 - 6
				Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			    elsif dir4 = 4 and dir4 not= 3 then

				x4 := x4 + 6
				Draw.FillBox (x4, y4, x4 + 4, y4 + 4, clr4)

			    end if

			end if

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		if taken ((x1 - 2) div 6, (y1 - 2) div 6) then   % detects when players have crashed

		    flag1 := 1

		end if

		if taken ((x2 - 2) div 6, (y2 - 2) div 6) then

		    flag2 := 1

		end if

		if numplayers = 4 then

		    if taken ((x3 - 2) div 6, (y3 - 2) div 6) then

			flag3 := 1

		    end if

		    if taken ((x4 - 2) div 6, (y4 - 2) div 6) then

			flag4 := 1

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		if x1 = x2 and y1 = y2 then   % for detecting perpendicular collisions

		    flag1 := 1
		    flag2 := 1

		end if

		if numplayers = 4 then

		    if x1 = x3 and y1 = y3 then

			flag1 := 1
			flag3 := 1

		    elsif x1 = x4 and y1 = y4 then

			flag1 := 1
			flag4 := 1

		    elsif x2 = x3 and y2 = y3 then

			flag2 := 1
			flag3 := 1

		    elsif x2 = x4 and y2 = y4 then

			flag2 := 1
			flag4 := 1

		    elsif x3 = x4 and y3 = y4 then

			flag3 := 1
			flag4 := 1

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		if numplayers = 4 then   % next ~190 lines for assigning points, drawing crash pictures, and ending each round

		    if flag1 + flag2 + flag3 + flag4 = 4 then

			Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)   % Draws explosions - all players dead
			Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
			Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
			View.Update
			Draw.Text ("NOBODY WINS!", 70, 160, font3, 49)  
			exit

		    elsif flag1 + flag2 + flag3 + flag4 = 3 then   % 3 players dead. Assign winner.

			if flag1 = 0 then
			    score1 := score1 + 1
			    Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			    Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
			    Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
			    View.Update
			    Draw.Text ("PLAYER 1 WINS!", 70, 160, font3, 49)
			    exit
			elsif flag2 = 0 then
			    score2 := score2 + 1
			    Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
			    Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
			    Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
			    View.Update
			    Draw.Text ("PLAYER 2 WINS!", 70, 160, font3, 49)
			    exit
			elsif flag3 = 0 then
			    score3 := score3 + 1
			    Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
			    Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			    Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
			    View.Update
			    Draw.Text ("PLAYER 3 WINS!", 70, 160, font3, 49)
			    exit
			elsif flag4 = 0 then
			    score4 := score4 + 1
			    Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			    Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
			    Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
			    View.Update
			    Draw.Text ("PLAYER 4 WINS!", 70, 160, font3, 49)
			    exit
			end if

		    elsif flag1 + flag2 + flag3 + flag4 = 2 then   % 2 players dead. Game continues

			if done1 = 0 then

			    if flag1 = 1 and flag2 = 1 then

				score3 := score3 + 1
				score4 := score4 + 1
				done1 := 1
				Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
				Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
				View.Update

			    elsif flag1 = 1 and flag3 = 1 then

				score2 := score2 + 1
				score4 := score4 + 1
				done1 := 1
				Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
				Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
				View.Update

			    elsif flag1 = 1 and flag4 = 1 then

				score2 := score2 + 1
				score3 := score3 + 1
				done1 := 1
				Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
				Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
				View.Update

			    elsif flag2 = 1 and flag3 = 1 then

				score1 := score1 + 1
				score4 := score4 + 1
				done1 := 1
				Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
				Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
				View.Update

			    elsif flag2 = 1 and flag4 = 1 then

				score1 := score1 + 1
				score3 := score3 + 1
				done1 := 1
				Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
				Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
				View.Update

			    elsif flag3 = 1 and flag4 = 1 then

				score1 := score1 + 1
				score2 := score2 + 1
				done1 := 1
				Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
				Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
				View.Update

			    end if

			end if

		    elsif flag1 + flag2 + flag3 + flag4 = 1 then   % 1 player is dead. game continues

			if done2 = 0 then

			    if flag1 = 1 then

				score2 := score2 + 1
				score3 := score3 + 1
				score4 := score4 + 1
				done2 := 1
				Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
				View.Update

			    elsif flag2 = 1 then

				score1 := score1 + 1
				score3 := score3 + 1
				score4 := score4 + 1
				done2 := 1
				Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
				View.Update

			    elsif flag3 = 1 then

				score1 := score1 + 1
				score2 := score2 + 1
				score4 := score4 + 1
				done2 := 1
				Pic.Draw (picID5, x3 - 60, y3 - 60, picCopy)
				View.Update

			    elsif flag4 = 1 then

				score1 := score1 + 1
				score2 := score2 + 1
				score3 := score3 + 1
				done2 := 1
				Pic.Draw (picID5, x4 - 60, y4 - 60, picCopy)
				View.Update

			    end if

			end if

		    end if

		elsif numplayers = 2 then   % 2 player game. Determine end of game

		    if flag1 + flag2 = 2 then

			Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
			View.Update
			Draw.Text ("NOBODY WINS!", 70, 160, font3, 49)
			exit

		    elsif flag1 + flag2 = 1 then

			if flag1 = 1 then

			    score2 := score2 + 1
			    Pic.Draw (picID5, x1 - 60, y1 - 60, picCopy)
			    Draw.Text ("PLAYER 2 WINS!", 70, 160, font3, 49)
			    View.Update
			    exit

			elsif flag2 = 1 then

			    score1 := score1 + 1
			    Pic.Draw (picID5, x2 - 60, y2 - 60, picCopy)
			    Draw.Text ("PLAYER 1 WINS!", 70, 160, font3, 49)
			    View.Update
			    exit

			end if

		    end if

		end if

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		View.Update
		delay (22)   % The number of milliseconds the program will wait before going through the loop again

	    end loop

	    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	    Draw.Text ("PLAYER 1 SCORE :  " + intstr (score1), 30, 530, font2, 42)
	    Draw.Text ("PLAYER 2 SCORE :  " + intstr (score2), 30, 480, font2, 38)

	    if numplayers = 4 then   % Draws each players score after each round

		Draw.Text ("PLAYER 3 SCORE :  " + intstr (score3), 30, 430, font2, 48)
		Draw.Text ("PLAYER 4 SCORE :  " + intstr (score4), 30, 380, font2, 53)

	    end if

	    Draw.Text (title9, maxx div 2 - twidth9 div 2, 40, font1, 46)
	    View.Update

	    leave := false

	    ch := getchar
	    if ch = 'y' or ch = 'Y' then   % The option to return to the main menu
		leave := true
	    end if

	    if leave = true then
		cls
		exit
	    end if

	end loop

    end if

end loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cls
border (1, 5, 0, 99, 0, 99, 2)

Draw.Text ("Designed by: Keri Warr", 30, 530, font2, 42)   % Credits.
Draw.Text ("Programmed by: Keri Warr", 30, 480, font2, 38)
Draw.Text ("Edited by: Keri Warr", 30, 430, font2, 48)
Draw.Text ("Thanks for Playing! =]", 130, 300, font2, 53)
View.Update

delay (7000)
complete := true   % Stop Music
Music.PlayFileStop

cls   % Blank screen
View.Update

