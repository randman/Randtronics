package utils 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Rand Anderson
	 */
	public class SWFLoader extends EventDispatcher 
	{
		private var loader:Loader = null;
		private var swfCallback:Function = null;
		
		public function SWFLoader(path:String, file:String, aswfCallback:Function):void
		{
			swfCallback = aswfCallback;
			var are:URLRequest = new URLRequest(path+file);
			var _lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, swfLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, swfLoadError);
			loader.load(are,_lc);
		}
		private function swfLoadComplete(evt:Event):void
		{
			removeListeners();
			swfCallback(loader.content as MovieClip);
		}
		private function swfLoadError(evt:IOErrorEvent):void
		{
		  trace("Unable to load swf ");
		  removeListeners();
		}
		private function removeListeners():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, swfLoadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, swfLoadError);
		}
		public function destroy():void
		{
			removeListeners();
			loader = null;
			swfCallback = null;
		}
	}

}