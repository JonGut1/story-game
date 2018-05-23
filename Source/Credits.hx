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

class Credits extends Sprite

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
		//calls this function
		drawScreen();
	}

	//Displays the menu image, adds button images, also adds credits text.
	public function drawScreen()
	{

		var bitmapDataCreateScreen = Assets.getBitmapData("img/Menu_Screen720p.png"); 
		var bitmap = new Bitmap (bitmapDataCreateScreen); 
		addChild(bitmap);

		var bitmapDataBack = Assets.getBitmapData("img/Back.jpg"); 
		var back = new Bitmap (bitmapDataBack); 
		var backSprite = new Sprite (); 

		backSprite.x = 50;
		backSprite.y = 50;
		backSprite.addChild(back);
		backSprite.scaleY=0.7;
		backSprite.scaleX=0.7;
		addChild(backSprite);
		backSprite.addEventListener(MouseEvent.CLICK, onClickBack);

		var format:TextFormat = new TextFormat( "_sans", 24, 0xFFFFFF, true );

		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.text = 
		"                      Credits

Lead coder............Jonas Gutauskas
Concept artist.......Jonas Gutauskas
Lead designer.......Jonas Gutauskas
Story writer.............Jonas Gutausks
UI designer............Jonas Gutauskas
UI artist.................Jonas Gutauskas";
		field.x = 350;
		field.y = 100;
		addChild(field);
	}

	//plays an animation is played  
	// after a certain time delay from when this function was called it will call different function 
	function onClickBack(event:MouseEvent)
	{
		var backSprite : Sprite = cast(event.target);
		backSprite.scaleX = 0.66;//scales down the clicked image
		backSprite.scaleY = 0.66;//scales down the clicked image
		Actuate.tween(backSprite, 0.7, { scaleX: 0.7 });//scales up the clicked image
		Actuate.tween(backSprite, 0.7, { scaleY: 0.7 });//scales up the clicked image
		
		haxe.Timer.delay(navigateToMenuScreen, 200);//a delay before calling a different function
	}


}