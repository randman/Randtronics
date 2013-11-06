package views 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Rand Anderson
	 */
	public class View extends Sprite 
	{
		private var loader:Loader = null;
		private var mc:String = "myLogo";// "logo2";
		
		public function View() 
		{
			super();
			//init();
		}
		public function init(path:String, file:String, amc:String):void
		{
			mc = amc;
			var are:URLRequest = new URLRequest(path+file);
			var _lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, swfLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, swfLoadError);
			loader.load(are,_lc);
		}
		private function swfLoadComplete(evt:Event):void
		{
			var mySwf:MovieClip = loader.content as MovieClip;
			var mySwf2:MovieClip = mySwf.getChildByName(mc) as MovieClip;
			addChild(mySwf2);
			trace("mySwf2.width="+mySwf2.width);
			trace("mySwf2.height=" + mySwf2.height);
			mySwf2.width = mySwf2.width * 2;
			mySwf2.height = mySwf2.height * 2;
			trace("mySwf2.width="+mySwf2.width);
			trace("mySwf2.height=" + mySwf2.height);
			loader.removeEventListener(Event.COMPLETE, swfLoadComplete);
		}
		private function swfLoadError(evt:IOErrorEvent):void
		{
		  trace("Unable to load swf ");
		  loader.removeEventListener(IOErrorEvent.IO_ERROR, swfLoadError);
		}
	}

}