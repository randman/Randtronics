package models 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Rand Anderson
	 */
	public class Model extends EventDispatcher 
	{
		public static var SCREENSAVER_SHOW:String = "SCREENSAVER_SHOW";
		public static var SCREENSAVER_PROGRESS:String = "SCREENSAVER_PROGRESS";
		public static var SCREENSAVER_HIDE:String = "SCREENSAVER_HIDE";
		
		private var _stage:Stage = null;
		private var _appData:Object = null;
		private var _appSwf:MovieClip = null;
		private var _screensaver:MovieClip = null;
		
		public function Model() 
		{
		
		}
		public function get appData():Object 
		{
			return _appData;
		}
		public function set appData(value:Object):void 
		{
			_appData = value;
		}
		public function get appSwf():MovieClip 
		{
			return _appSwf;
		}
		public function set appSwf(value:MovieClip):void 
		{
			_appSwf = value;
		}
		public function getLibraryItem(className:String, instName:String):MovieClip
		{
			var cls:Class = _appSwf.loaderInfo.applicationDomain.getDefinition(className) as Class;
			if (cls)
			{
				var instMC:MovieClip = new cls();
				instMC.name = instName;
				return instMC;
			}
			return null;
		}
		public function get stage():Stage 
		{
			return _stage;
		}
		public function set stage(value:Stage):void 
		{
			_stage = value;
		}
		public function get screensaver():MovieClip 
		{
			return _screensaver;
		}
		
		public function set screensaver(value:MovieClip):void 
		{
			_screensaver = value;
		}
		public function showScreenSaver():void 
		{ 
			trace("showScreenSaver");
			_screensaver.visible = true;
		}
		public function hideScreenSaver():void 
		{ 
			trace("hideScreenSaver");
			_screensaver.visible = false;
		}
	}

}