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

class Scene extends Sprite

{
	var timerField:TextField;
	var timer:Int = 10000;
	var lastTime:Int;

	var answers:Array<TextField>;
	var textField:TextField;
	var textFieldOption:TextField;
	var textFieldOption2:TextField;
	var textFieldOption3:TextField;

	var nextSc:Array<Int>;
	var theScene:Int;

	public function new() 
	{
		super();
		//adds an event which calles an init function
		addEventListener( Event.ADDED_TO_STAGE, init );
		//adds an event which calles an update function
		addEventListener(Event.ENTER_FRAME, update);

		answerFormat();
		getScene(1);
	}

	public function navigateToWiningScreen()
	{
		//goes to a main class and then swithces to a winingscreen class
		Main.getInstance().switchScreen(Main.WININGSCREEN_SCREEN);
	}
	public function navigateToLosingScreen()
	{
		//goes to a main class and then swithces to a losingscreen class
		Main.getInstance().switchScreen(Main.LOSINGSCREEN_SCREEN);
	}

	function init(event:Event)
	{
		//removes the event from function init
		removeEventListener(Event.ADDED_TO_STAGE, init);
		createTimerField();
	}

	//creates a timer field which displays timer
	function createTimerField() 
	{
		var format:TextFormat = new TextFormat( "_sans", 30, 0xFFFFFF, true );

		timerField = new TextField();
		timerField.defaultTextFormat = format;
		timerField.autoSize = TextFieldAutoSize.LEFT;
		
		timerField.x = 590;
		timerField.y = 400;
		
		addChild(timerField);
		lastTime = Lib.getTimer();// stores current timer in the variable
	}

	//updates the timer so it will count down
	private function update(e:Event)
	{
		var now:Int = Lib.getTimer();//stores current time in the variable
		var deltaTime:Int = now - lastTime;//subtracts latTime from the current time
		lastTime = now; 
		
		timer -= deltaTime;//always counts fown the subtracted amount
		
		timerField.text = Std.string(timer);//displays the timer

		if (timer <= 0) //if the timer is less or equal to 0 
		{
			trace("Stop");
			navigateToLosingScreen();
			removeEventListener(Event.ENTER_FRAME, update);//removes event which calls update function

		}
		else
		{
			trace("continue");
		}
	}	

	//a format for the option text
	function answerFormat()
	{
		removeChildren();
		var format:TextFormat = new TextFormat( "_sans", 20, 0xFFFFFF, true );
		textFieldOption = new TextField();
		textFieldOption.defaultTextFormat = format;
		textFieldOption.autoSize = TextFieldAutoSize.LEFT;
		textFieldOption.y = 150;
		textFieldOption.x = 350;
		
		addChild(textFieldOption);

		textFieldOption2 = new TextField();
		textFieldOption2.defaultTextFormat = format;
		textFieldOption2.autoSize = TextFieldAutoSize.LEFT;
		textFieldOption2.y = 200;
		textFieldOption2.x = 350;
		
		addChild(textFieldOption2);

		textFieldOption3 = new TextField();
		textFieldOption3.defaultTextFormat = format;
		textFieldOption3.autoSize = TextFieldAutoSize.LEFT;
		textFieldOption3.y = 250;
		textFieldOption3.x = 350;
		
		addChild(textFieldOption3);	
	}

	//a function where a specified scene is taken out of the database
	function getScene(sceneId:Int)
	{
		var connection = Sqlite.open("data/database.db");//connects to a specidied database

		var resultSet:ResultSet = connection.request('SELECT * FROM scene WHERE sceneID = $sceneId');//selects everything from a specified table and selects a sceneID from the typed number
		for (row in resultSet)
		{
			trace(row.sceneID);

			var format:TextFormat = new TextFormat( "_sans", 30, 0xFFFFFF, true );

			textField = new TextField();
			textField.defaultTextFormat = format;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.x = 300;
			textField.y = 100;
			textField.text = row.question;
			addChild(textField);		
		}	
		var connection = Sqlite.open("data/database.db");

		var resultSet:ResultSet = connection.request('SELECT * FROM option WHERE sceneID = $sceneId');
		answers = new Array<TextField>();
		nextSc = new Array<Int>();

		for (row in resultSet)
		{
			
			trace(row.sceneID);

			answers.push(row.option);//adds options from a database to an array	
			nextSc.push(row.next);//adds the next scene data into an array	
		}				
		connection.close();
		displayOptions();
	}

	//displays objects from an array
	function displayOptions()
	{	
		if(answers.length > 0)//if array is bigger than 0
		{
			var theAnswers:TextField = answers[0];//stores the first object in the array
			textFieldOption.text = Std.string(theAnswers);//displays that object
			textFieldOption.addEventListener(MouseEvent.CLICK, nextScene);//calls a function when clicked
		
			var theAnswers:TextField = answers[1];//stores the second object in the array
			textFieldOption2.text = Std.string(theAnswers);//displays that object
			textFieldOption2.addEventListener(MouseEvent.CLICK, nextSceneLosing);//calls a function when clicked

			var theAnswers:TextField = answers[2];//stores the third object in the array
			textFieldOption3.text = Std.string(theAnswers);//displays that object
			textFieldOption3.addEventListener(MouseEvent.CLICK, nextScene);//calls a function when clicked
		}
		else
		{
			navigateToWiningScreen();//navigates to wining screen if the array is <=0
		}	
	}

	//a function for determining what kind of scene needs to be loaded
	function nextScene(event:MouseEvent)
	{
			removeEventListener(Event.ENTER_FRAME, update);//calls an update function
			removeChild(timerField);//adds timer

			removeChild(textField);//removes text field
			theScene = nextSc.pop();//stores the array integer into a variable 

			getScene(theScene);//loads the scene with the stored integer from the variable
	}

	//a function for determining what kind of scene needs to be loaded
	function nextSceneLosing(event:MouseEvent)
	{
			removeEventListener(Event.ENTER_FRAME, update);//calls an update function
			removeChild(timerField);//adds timer

			removeChild(textField);//removes text field
			theScene = nextSc.pop();//stores the array integer into a variable 
			if(theScene == 5)//if theScene variable is equal to 5
			{
				navigateToLosingScreen();//calls a losing screen function
			}
			else
			{
			
				getScene(theScene);//loads the scene with the stored integer from the variable
			}
	}


}
