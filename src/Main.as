package 
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import models.Model;
	import utils.SWFLoader;
	import utils.XMLLoader;
	
	/**
	 * ...
	 * @author Rand Anderson
	 */
	public class Main extends Sprite 
	{
		private var sleeping:Boolean = true;
		private var xmlLoader:XMLLoader = null;
		private var swfLoader:SWFLoader = null;
		private var baseScreen:Sprite = null;
		private var splashScreen:MovieClip = null;
		private var model:Model = null;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			model = new Model();
			model.stage = stage;
			addListeners();
			init("Application.xml");
		}
		public function init(astr:String):void 
		{
			baseScreen = new Sprite();
			addChild(baseScreen);
			xmlLoader = new XMLLoader(astr, dataCallback);
		}
		private function dataCallback(astr:Object):void 
		{
			trace("dataCallback" + astr);
			model.appData = astr;
			xmlLoader.destroy();
			xmlLoader = null;
			var myFile:String = astr.file;
			////////////TODO Switch for OS
			swfLoader = new SWFLoader(astr.path,myFile, swfCallback);
			/*
				guid = bcdd66a3-28dc-4263-9294-6283aa19ec51
				fileAndroid = NextCameraAssets_android.swf
				gps = true
				screen = Main.xml
				fileIOS = NextCameraAssets_ios.swf
				versionNumber = 0.1
				logo = myLogo
				file = NextCameraAssets.swf
				id = air.Randtronics.Tester
				splash = logo2
				name = Tester
				path = http://166.78.187.54/
			*/
		}
		private function swfCallback(aSWf:MovieClip):void 
		{
			model.appSwf = aSWf;
			swfLoader.destroy();
			swfLoader = null;
			//var aMC:MovieClip = model.appSwf.getChildByName(model.appData.splash) as MovieClip;
			var aMC:MovieClip = model.getLibraryItem(model.appData.splash,"SplashMC")
			splashScreen = new MovieClip();
			addChild(splashScreen);
			aMC.width = model.stage.stageWidth;
			aMC.scaleY = aMC.scaleX;
			//aMC.x = 0;
			splashScreen.addChild(aMC);
			model.screensaver = splashScreen;
		}
		private function addListeners():void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deactivate);
			NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, networkChange);
			NativeApplication.nativeApplication.addEventListener(Event.USER_IDLE, userIdle);
			NativeApplication.nativeApplication.addEventListener(Event.USER_PRESENT, userPresent);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, invoke);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		private function removeListeners():void 
		{
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, activate);
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, deactivate);
			NativeApplication.nativeApplication.removeEventListener(Event.NETWORK_CHANGE, networkChange);
			NativeApplication.nativeApplication.removeEventListener(Event.USER_IDLE, userIdle);
			NativeApplication.nativeApplication.removeEventListener(Event.USER_PRESENT, userPresent);
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, invoke);
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		private function activate(e:Event):void 
		{
			trace(e.toString()); 
			sleeping = false;
		}
		private function deactivate(e:Event):void 
		{ 
			trace(e.toString()); 
			sleeping = true;
			//destroy();
		}
		private function keyDown(e:KeyboardEvent):void 
		{ 
			var akey:uint = e.keyCode;
			trace("key=" + akey);
			switch(akey)
			{
				case Keyboard.BACK:
					trace("BACK=" + Keyboard.BACK);
					doBack();
					break;
				case Keyboard.MENU:
					trace("MENU=" + Keyboard.MENU);
					doMenu();
					break;	
				case Keyboard.SEARCH:
					trace("SEARCH=" + Keyboard.SEARCH);
					doSearch();
					break;	
			}
		}
		private function doBack():void 
		{ 
			trace("doBack");
			removeScreen(getChildAt(numChildren-1));
		}
		private function doMenu():void 
		{ 
			trace("doMenu");
		}
		private function doSearch():void 
		{ 
			trace("doSearch");
			var aScreen:Sprite = Sprite(getChildAt(numChildren - 1));
			trace("aScreen="+aScreen)
		}
		private function addScreen(aSprite:Sprite):void 
		{
			baseScreen.addChild(aSprite);
			trace("addScreen"+this.numChildren);
		}
		private function removeScreen(aSprite:DisplayObject):void 
		{
			baseScreen.removeChild(aSprite);
			trace("removeScreen"+this.numChildren);
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////
		private function networkChange(e:Event):void { trace(e.toString()); }
		private function userIdle(e:Event):void { trace(e.toString()); }
		private function userPresent(e:Event):void { trace(e.toString()); }
		private function invoke(e:Event):void { trace(e.toString()); }
		private function destroy():void 
		{
			removeChild(baseScreen);
			baseScreen = null;
			removeChild(splashScreen);
			splashScreen = null;
			model.screensaver = null;
			removeListeners();
			NativeApplication.nativeApplication.exit();
		}
	}
	
}