type HealthBarType
	imgOverLay as integer
	sprOverLay as integer
	imgBar as integer
	sprBar as integer
	sizeX as float
	sizeY as float
	positionX as float
	positionY as float
	percentage as float
	healthMax as float
	sprText as integer
endtype

function CreateHealthBar(bar ref as HealthBarType)
	if bar.sprBar = 0
		bar.sprBar = CreateSprite(bar.imgBar)
		bar.sprOverLay = CreateSprite(bar.imgOverLay)
		SetSpriteSize(bar.sprBar, bar.sizeX-1, bar.sizeY)
		SetSpritePosition(bar.sprBar, bar.positionX+0.1, bar.positionY+0.1)
		SetSpriteDepth(bar.sprBar, 11)
		SetSpriteSize(bar.sprOverLay, bar.sizeX, bar.sizeY)
		SetSpritePosition(bar.sprOverLay, bar.positionX, bar.positionY)
		
		bar.sprText = CreateText(Str(bar.healthMax * bar.percentage, 0))
		SetTextAlignment(bar.sprText, 1)
		SetTextPosition(bar.sprText, 50, bar.positionY + GetSpriteHeight(bar.sprOverLay)/2 - GetTextSize(bar.sprText)/2)
		Sync()
	endif
endfunction 

function UpdateHealthBar(bar as HealthBarType)
	SetSpriteScale(bar.sprBar, bar.percentage, 1)
	SetTextString(bar.sprText, Str(bar.healthMax * bar.percentage, 0))
	//Sync()
	//SetSpriteSize(bar.sprBar, (bar.sizeX * bar.percentage / 100.0), bar.sizeY)
endfunction

function DestoryHealthBar(bar ref as HealthBarType)
	//SetTextVisible(bar.sprText, 0)
	DeleteText(bar.sprText)
	bar.sprText = 0
	DeleteSprite(bar.sprOverLay)
	bar.sprOverLay = 0
	DeleteSprite(bar.sprBar)
	bar.sprBar = 0
endfunction
