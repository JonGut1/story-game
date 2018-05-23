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

import sys.db.Sqlite;
import sys.db.Connection;
import sys.db.ResultSet;

class LosingScreen extends Sprite

{
	
	public function new() 
	{
		super();
		//adds an event which calles an init function
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	public function navigateToMenuScreen()
	{
		//goes to a main class and then swithces to a menu class
		Main.getInstance().switchScreen(Main.MENU_SCREEN);
	}

	public function navigateToFameScreen()
	{
		//goes to a main class and then swithces to a fame class
		Main.getInstance().switchScreen(Main.FAME_SCREEN);
	}

	function init(event:Event)
	{
		//removes the event from function init
		removeEventListener(Event.ADDED_TO_STAGE, init);
		drawScreen();
	}

	//Adds button images, also adds some text.
	function drawScreen()
	{
		var bitmapDataFinnish = Assets.getBitmapData("img/Finish.png"); 
		var finnish = new Bitmap (bitmapDataFinnish); 
		var finnishSprite = new Sprite (); 

		finnishSprite.x = 540;
		finnishSprite.y = 400;
		finnishSprite.addChild(finnish);
		finnishSprite.scaleY=0.7;
		finnishSprite.scaleX=0.7;
		addChild(finnishSprite);
		finnishSprite.addEventListener(MouseEvent.CLICK, onClickFinnish);

		var bitmapDataHallOfFame = Assets.getBitmapData("img/Fame.jpg"); 
		var hallOfFame = new Bitmap (bitmapDataHallOfFame); 
		var hallOfFameSprite = new Sprite (); 

		hallOfFameSprite.x = 470;
		hallOfFameSprite.y = 600;
		hallOfFameSprite.addChild(hallOfFame);
		hallOfFameSprite.scaleY=0.7;
		hallOfFameSprite.scaleX=0.7;
		addChild(hallOfFameSprite);
		hallOfFameSprite.addEventListener(MouseEvent.CLICK, onClickFame);

		var format:TextFormat = new TextFormat( "_sans", 24, 0xFFFFFF, true );

		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.text = "Unfortunately for some kind of unknown reason you lost.";
		field.x = 200;
		field.y = 180;
		addChild(field);	
	}

	//plays an animation is played 
	// after a certain time delay from when this function was called it will call different function
	function onClickFinnish(event:MouseEvent)
	{
		var finnishSprite : Sprite = cast(event.target);
		finnishSprite.scaleX = 0.66;
		finnishSprite.scaleY = 0.66;
		Actuate.tween(finnishSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(finnishSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToMenuScreen, 200);//a delay before calling a different function
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

}
