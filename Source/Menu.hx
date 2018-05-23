package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

import motion.Actuate;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.MouseEvent;

import openfl.display.SimpleButton;
import openfl.events.Event;
import flash.Lib;
import openfl.display.DisplayObject;
import haxe.Timer;

class Menu extends Sprite

{
	public function new() 
	{
		super();
		//adds an event which calles an init function
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	public function navigateToFameScreen()
	{
		//goes to a main class and then swithces to a fame class
		Main.getInstance().switchScreen(Main.FAME_SCREEN);
	}

	public function navigateToGameplayScreen()
	{
		//goes to a main class and then swithces to a gameplay class
		Main.getInstance().switchScreen(Main.GAMEPLAY_SCREEN);
	}

	public function navigateToCreditsScreen()
	{
		//goes to a main class and then swithces to a credits class
		Main.getInstance().switchScreen(Main.CREDITS_SCREEN);
	}

	public function navigateToQuitScreen()
	{
		Main.getInstance().switchScreen(Main.QUIT_SCREEN);
	}

	function init(event:Event)
	{
		//removes the event from function init
		removeEventListener(Event.ADDED_TO_STAGE, init);
		drawScreen();
	}
	
	//Displays the menu image, adds button images.
	public function drawScreen()
	{
		var bitmapDataCreateScreen = Assets.getBitmapData("img/Menu_Screen720p.png"); 
		var bitmap = new Bitmap (bitmapDataCreateScreen); 
		addChild(bitmap);

		var bitmapDataStartGame = Assets.getBitmapData("img/Start_Game.jpg"); 
		var startGame = new Bitmap (bitmapDataStartGame); 
		var startGameSprite = new Sprite (); 

		startGameSprite.x = 200;
		startGameSprite.y = 100;
		startGameSprite.addChild(startGame);
		startGameSprite.scaleY=0.7;
		startGameSprite.scaleX=0.7;
		addChild(startGameSprite);
		startGameSprite.addEventListener(MouseEvent.CLICK, onClickStart);

		var bitmapDataHallOfFame = Assets.getBitmapData("img/Fame.jpg"); 
		var hallOfFame = new Bitmap (bitmapDataHallOfFame); 
		var hallOfFameSprite = new Sprite (); 

		hallOfFameSprite.x = 200;
		hallOfFameSprite.y = 150;
		hallOfFameSprite.addChild(hallOfFame);
		hallOfFameSprite.scaleY=0.7;
		hallOfFameSprite.scaleX=0.7;
		addChild(hallOfFameSprite);
		hallOfFameSprite.addEventListener(MouseEvent.CLICK, onClickFame);

		var bitmapDataCredits = Assets.getBitmapData("img/Credits.jpg"); 
		var credits = new Bitmap (bitmapDataCredits); 
		var creditsSprite = new Sprite (); 

		creditsSprite.x = 200;
		creditsSprite.y = 200;
		creditsSprite.addChild(credits);
		creditsSprite.scaleY=0.7;
		creditsSprite.scaleX=0.7;
		addChild(creditsSprite);
		creditsSprite.addEventListener(MouseEvent.CLICK, onClickCredits);

		var bitmapDataQuit = Assets.getBitmapData("img/Quit.jpg"); 
		var quit = new Bitmap (bitmapDataQuit); 
		var quitSprite = new Sprite (); 

		quitSprite.x = 200;
		quitSprite.y = 250;
		quitSprite.addChild(quit);
		quitSprite.scaleY=0.7;
		quitSprite.scaleX=0.7;
		addChild(quitSprite);
		quitSprite.addEventListener(MouseEvent.CLICK, onClickQuit);
	}

	//plays an animation is played 
	// after a certain time delay from when this function was called it will call different function
	function onClickStart(event:MouseEvent)
	{
		var startGameSprite : Sprite = cast(event.target);
		startGameSprite.scaleX = 0.66;
		startGameSprite.scaleY = 0.66;
		Actuate.tween(startGameSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(startGameSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToGameplayScreen, 200);//a delay before calling a different function
	}

	function onClickFame(event:MouseEvent)
	{
		var hallOfFameSprite : Sprite = cast(event.target);
		hallOfFameSprite.scaleX = 0.66;
		hallOfFameSprite.scaleY = 0.66;
		Actuate.tween(hallOfFameSprite, 0.66, { scaleX: 0.7 });
		Actuate.tween(hallOfFameSprite, 0.66, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToFameScreen, 200);//a delay before calling a different function
	}

	function onClickCredits(event:MouseEvent)
	{
		var creditsSprite : Sprite = cast(event.target);
		creditsSprite.scaleX = 0.66;
		creditsSprite.scaleY = 0.66;
		Actuate.tween(creditsSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(creditsSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToCreditsScreen, 200);//a delay before calling a different function
	}

	function onClickQuit(event:MouseEvent)
	{
		var quitSprite : Sprite = cast(event.target);
		quitSprite.scaleX = 0.66;
		quitSprite.scaleY = 0.66;
		Actuate.tween(quitSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(quitSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToQuitScreen, 200);//a delay before calling a different function
	}


}



