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

class Fame extends Sprite

{	
	var connection:Connection;
	var resultSet:ResultSet;
	var names:Array<TextField>;
	var fieldText:TextField;
	var iD:Int;

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

	//Displays the menu image, adds button images, also adds some text.
	public function drawScreen()
	{
		var bitmapDataCreateScreen = Assets.getBitmapData("img/Menu_Screen720p.png"); 
		var bitmap = new Bitmap (bitmapDataCreateScreen); 
		addChild(bitmap);

		var format:TextFormat = new TextFormat( "_sans", 30, 0xFFFFFF, true );

		var fieldText:TextField = new TextField();
		fieldText.defaultTextFormat = format;
		fieldText.autoSize = TextFieldAutoSize.LEFT;
		fieldText.text = "Recent players";
		fieldText.x = 300;
		fieldText.y = 100;
		addChild(fieldText);

		//back button image
		var bitmapDataBack = Assets.getBitmapData("img/Back.jpg"); 
		var back = new Bitmap (bitmapDataBack); 
		var backSprite = new Sprite (); 

		backSprite.x = 50;
		backSprite.y = 50;
		backSprite.addChild(back);
		backSprite.scaleY=0.7;
		backSprite.scaleX=0.7;
		addChild(backSprite);
		backSprite.addEventListener(MouseEvent.CLICK, onClickBack); //navigates to a different function when clicked

		//a frame
		var bitmapDataFrame = Assets.getBitmapData("img/Frame.png"); 
		var frame = new Bitmap (bitmapDataFrame); 
		var frameSprite = new Sprite (); 

		frameSprite.x = 215;
		frameSprite.y = 150;
		frameSprite.addChild(frame);
		frameSprite.scaleY=0.35;
		frameSprite.scaleX=0.5;
		addChild(frameSprite);

		readHallOfFame();//activates this function
		displayNames();//activates this function
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

	//a function which reads data from the database
	function readHallOfFame()
	{
		connection = Sqlite.open("data/database.db");//connects to a specified database
		resultSet = connection.request("SELECT * FROM halloffame");//selects items from a databse and from a certain table in the database

		names = new Array<TextField>();//an array in which all of the names from the database will be stored
		for (row in resultSet)
		{
			trace(row.name);	
			names.push(row.name);//stores everything from a specified row into an array
		}
		connection.close();
	}

	//a function to display names that were stored in an array
	function displayNames()
	{
		var format:TextFormat = new TextFormat( "_sans", 20, 0xFFFFFF, true );

		var field:TextField = new TextField();
		field.defaultTextFormat = format;
		field.autoSize = TextFieldAutoSize.LEFT;
		field.x = 300;
		field.y = 200;
		addChild(field);

		var field2:TextField = new TextField();
		field2.defaultTextFormat = format;
		field2.autoSize = TextFieldAutoSize.LEFT;
		field2.x = 300;
		field2.y = 250;
		addChild(field2);

		var field3:TextField = new TextField();
		field3.defaultTextFormat = format;
		field3.autoSize = TextFieldAutoSize.LEFT;
		field3.x = 300;
		field3.y = 300;
		addChild(field3);

		var field4:TextField = new TextField();
		field4.defaultTextFormat = format;
		field4.autoSize = TextFieldAutoSize.LEFT;
		field4.x = 300;
		field4.y = 350;
		addChild(field4);

		var field5:TextField = new TextField();
		field5.defaultTextFormat = format;
		field5.autoSize = TextFieldAutoSize.LEFT;
		field5.x = 300;
		field5.y = 400;
		addChild(field5);

		var theNames:TextField = names[0];//a first object in an array is stored in a variable
		field.text = Std.string(theNames);//the variable is displayed with the specified text variable

		var theNames2:TextField = names[1];
		field2.text = Std.string(theNames2);

		var theNames3:TextField = names[2];
		field3.text = Std.string(theNames3);

		var theNames4:TextField = names[3];
		field4.text = Std.string(theNames4);

		var theNames5:TextField = names[4];
		field5.text = Std.string(theNames5);
	}

}




