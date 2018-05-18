//*** Sets window size, title, background colour ***
//*** and orientation options. If w or h are ***
//*** zero, uses full screen. ***
function InitialiseScreen(w as integer, h as integer, t as string, c as integer, r as integer)
	//*** If no size given, use full screen ***
	if w = 0 or h = 0
		SetWindowSize(0,0,1)
	//*** else set size and title ***
	else
		SetWindowSize(w,h,0)
		//*** Set window title ***
		SetWindowTitle(t)
	endif
	//*** Set aspect ratio ***
	SetDisplayAspect(1.0*w/h)
	//*** Clear the screen to colour c ***
	SetClearColor((c&&0xFF0000)>>16,(c&&0xFF00)>>8,c&&0xFF)
	ClearScreen()
	//*** Set orientations allowed ***
	SetOrientationAllowed((r&&%1000)>>3,(r&&100)>>2, (r&&10)>>1, r&&1)
	//*** Use vector fonts ***
	UseNewDefaultFonts(1)
endfunction


//*** Displays image f in a full-screen sprite ***
function ShowSplashScreen(f as string)
	LoadImage(1,f)
	CreateSprite(1,1)
	SetSpriteSize(1,100,100)
	Sync()
endfunction


//*** Removes the splash screen after s ***
//*** seconds or after user click ***
function HideSplashScreen(s as integer)
	//*** Start timer ***
	ResetTimer()
	//*** Wait for time up or click ***
	while Timer() < s and GetPointerPressed() = 0
		Sync()
	endwhile
	//*** Delete sprite and image ***
	DeleteSprite(1)
	DeleteImage(1)
endfunction
