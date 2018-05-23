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

import openfl.events.KeyboardEvent;
import openfl.text.TextFieldType;
import openfl.text.TextFormatAlign;

class Gameplay extends Sprite

{
	var connection:Connection;
	var resultSet:ResultSet;
	var inputField:TextField;
	var outputField:TextField;
	
	public function new() 
	{
		super();
		//adds an event which calles an init function
		addEventListener(Event.ADDED_TO_STAGE, init);
	
	}

	public function navigateToMenuScreen()
	{
		removeChildren();
		//goes to a main class and then swithces to a menu class
		Main.getInstance().switchScreen(Main.MENU_SCREEN);
	}

	public function navigateToSceneScreen()
	{
		removeChildren();
		//goes to a main class and then swithces to a scene class
		Main.getInstance().switchScreen(Main.SCENE_SCREEN);
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

		var bitmapDataProceed = Assets.getBitmapData("img/Proceed.jpg"); 
		var proceed = new Bitmap (bitmapDataProceed); 
		var proceedSprite = new Sprite (); 

		proceedSprite.x = 502;
		proceedSprite.y = 400;
		proceedSprite.addChild(proceed);
		proceedSprite.scaleY=0.7;
		proceedSprite.scaleX=0.7;
		addChild(proceedSprite);
		proceedSprite.addEventListener(MouseEvent.CLICK, onClickProceed);

		var bitmapDataTextinput = Assets.getBitmapData("img/TextInput.jpg"); 
		var textInput = new Bitmap (bitmapDataTextinput); 
		var textInputSprite = new Sprite ();

		textInputSprite.x = 500;
		textInputSprite.y = 300;
		textInputSprite.addChild(textInput);
		textInputSprite.scaleY=0.7;
		textInputSprite.scaleX=0.7;
		addChild(textInputSprite); 

		var format:TextFormat = new TextFormat( "_sans", 24, 0xFFFFFF, true );

		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.text = "ENTER YOUR NAME";
		field.x = 480;
		field.y = 180;
		addChild(field);

		nameInput();
	}

	//plays an animation is played  
	// after a certain time delay from when this function was called it will call different function
	function onClickBack(event:MouseEvent)
	{
		var backSprite : Sprite = cast(event.target);
		backSprite.scaleX = 0.66;
		backSprite.scaleY = 0.66;
		Actuate.tween(backSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(backSprite, 0.7, { scaleY: 0.7 });
		
		haxe.Timer.delay(navigateToMenuScreen, 200);//a delay before calling a different function
	}

	function onClickProceed(event:MouseEvent)
	{
		var proceedSprite : Sprite = cast(event.target);
		proceedSprite.scaleX = 0.66;
		proceedSprite.scaleY = 0.66;
		Actuate.tween(proceedSprite, 0.7, { scaleX: 0.7 });
		Actuate.tween(proceedSprite, 0.7, { scaleY: 0.7 });
	
		haxe.Timer.delay(addName, 200);//a delay before calling a different function
	}

	//a function that creates a field for inouting some text
	private function nameInput():Void
	{
		var textFormat:TextFormat = new TextFormat( "_sans", 24, 0xFFFFFF, true);

		inputField = new TextField();
		inputField.defaultTextFormat = textFormat;
		inputField.type = TextFieldType.INPUT;
		inputField.width = 200;
		inputField.height = 50;
		inputField.x = 505;
		inputField.y = 300;
		addChild(inputField);

		outputField = new TextField();
	}

	//adds a name into a database
	private function addName()
	{
		//stores the text input into a variable
		outputField.text = '${inputField.text}';

		connection = Sqlite.open("data/database.db");//connects to a specified database
		resultSet = connection.request('INSERT INTO halloffame(name) VALUES("${inputField.text}")');//inserts text into a database
		connection.close();

		readHallOfFame();
		navigateToSceneScreen();		
	}

	//reads from the database
	function readHallOfFame()
	{
		connection = Sqlite.open("data/database.db");//connects to a specified database	
		resultSet = connection.request("SELECT * FROM halloffame");//selects everything from a specified table
		
		for (row in resultSet) 
		{
			trace(row.name);
		}
		connection.close();
	}
	
}


