package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.MouseEvent;

import openfl.display.SimpleButton;
import openfl.events.Event;
import flash.Lib;
import openfl.display.DisplayObject;
import haxe.Timer;

class Main extends Sprite 
{
	//the typed text cannot be chaged so it prevents typos
	public static inline var FAME_SCREEN:String = "fame screen";
	public static inline var MENU_SCREEN:String = "menu screen";
	public static inline var GAMEPLAY_SCREEN:String = "gameplay screen";
	public static inline var CREDITS_SCREEN:String = "credits screen";
	public static inline var QUIT_SCREEN:String = "quit screen";
	public static inline var SCENE_SCREEN:String = "scene screen";
	public static inline var WININGSCREEN_SCREEN:String = "winingscreen screen";
	public static inline var LOSINGSCREEN_SCREEN:String = "losingscreen screen";
	
	//current screen that is displayed
	var currentScreen:Sprite;

	public static var instance:Main;

	public function new () 
	{
		super ();

		instance = this;
		switchScreen( Main.MENU_SCREEN );
	}

	//this function lets other classes to get acces to the main class
	public static function getInstance():Main
	{
		return instance;
	}
	
	//loads a screen and removes the previous one
	public function switchScreen(whichScreen:String)
	{
		if(currentScreen != null)
		{
			removeChild(currentScreen);
		}
		//a list of screens to switch between
		switch( whichScreen )
		{
			case Main.MENU_SCREEN:
				currentScreen = new Menu();
			case Main.FAME_SCREEN:
				currentScreen = new Fame();
			case Main.GAMEPLAY_SCREEN:
				currentScreen = new Gameplay();
			case Main.CREDITS_SCREEN:
				currentScreen = new Credits();
			case Main.QUIT_SCREEN:
				currentScreen = new Quit();
			case Main.SCENE_SCREEN:
				currentScreen = new Scene();
			case Main.WININGSCREEN_SCREEN:
				currentScreen = new WiningScreen();
			case Main.LOSINGSCREEN_SCREEN:
				currentScreen = new LosingScreen();	
		}
		addChild(currentScreen);
	}
	
}