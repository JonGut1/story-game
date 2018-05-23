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

class Quit extends Sprite

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

	function init(event:Event)
	{
		//removes the event from function init
		removeEventListener(Event.ADDED_TO_STAGE, init);
		drawScreen();
	}

	//Displays the menu image, adds button images, also adds some text.
	public function drawScreen()
	{
		var bitmapDataCreateScreen = Assets.getBitmapData("img/Menu_Screen720p.png"); 
		var bitmap = new Bitmap (bitmapDataCreateScreen); 
		addChild(bitmap);

		var bitmapDataYes = Assets.getBitmapData("img/Yes.jpg"); 
		var yes = new Bitmap (bitmapDataYes); 
		var yesSprite = new Sprite (); 

		yesSprite.x = 400;
		yesSprite.y = 200;
		yesSprite.addChild(yes);
		yesSprite.scaleY=0.7;
		yesSprite.scaleX=0.7;
		addChild(yesSprite);
		yesSprite.addEventListener(MouseEvent.CLICK, onClickQuit);

		var bitmapDataNo = Assets.getBitmapData("img/No.jpg"); 
		var no = new Bitmap (bitmapDataNo); 
		var noSprite = new Sprite (); 

		noSprite.x = 600;
		noSprite.y = 200;
		noSprite.addChild(no);
		noSprite.scaleY=0.7;
		noSprite.scaleX=0.7;
		addChild(noSprite);
		noSprite.addEventListener(MouseEvent.CLICK, onClickBack);

		var format:TextFormat = new TextFormat( "_sans", 24, 0xFFFFFF, true );

		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.text = "Are you sure you want to exit the game?";
		field.x = 300;
		field.y = 100;
		addChild( field );
	}

	//plays an animation is played 
	// after a certain time delay from when this function was called it will call different function
	function onClickBack(event:MouseEvent)
	{
		var noSprite : Sprite = cast(event.target);
		noSprite.scaleX = 0.66;
		noSprite.scaleY = 0.66;
		Actuate.tween(noSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(noSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToMenuScreen, 200);//a delay before calling a different function
	}

	function onClickQuit(event:MouseEvent)
	{
		var yesSprite : Sprite = cast(event.target);
		yesSprite.scaleX = 0.66;
		yesSprite.scaleY = 0.66;
		Actuate.tween(yesSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(yesSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(exit, 200);//a delay before calling a different function
	}

	function exit()
	{
		Sys.exit(1);//closes the application
	}


}