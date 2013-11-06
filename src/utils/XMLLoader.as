package utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Rand Anderson
	 */
	public class XMLLoader extends EventDispatcher 
	{
		private var _file:String = "";
		private var _callback:Function = null;
		private var loader:URLLoader = null;
		
		public function XMLLoader(aFile:String, aCallback:Function) 
		{
			_file = aFile;
			_callback = aCallback;
			var myReq:URLRequest = new URLRequest(_file);
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.addEventListener(ProgressEvent.PROGRESS, progress);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			loader.load(myReq);
		}
		private function loadComplete(e:Event):void 
		{
			trace(e.toString()); 
			var myData:Object =  objectFromXML(new XML(loader.data))
			traceObject(myData);
			_callback(myData);
		}
		private function httpResponse(e:Event):void 
		{
			trace(e.toString()); 
		}
		private function ioError(e:Event):void 
		{
			trace(e.toString()); 
		}
		private function progress(e:Event):void 
		{
			trace(e.toString()); 
		}
		private function securityError(e:Event):void 
		{
			trace(e.toString()); 
		}
		private function objectFromXML(xml:XML):Object
		{
			var anObject:Object = new Object();
			if (xml != null&&xml!=""&&xml!="notfound")
			{
				for (var i:int = 0; i < xml.children().length() ; i++)
				{
					anObject[xml.children()[i].name().localName] = xml.children()[i];
				}		
			}
			return anObject;
		}
		private function traceObject(o:Object):void
		{
			trace('\n');
			for (var val:*in o)
			{
				trace('  ' + val + ' = ' + o[val]);
			}
			trace('\n');
		}
		public function destroy():void 
		{
			loader.removeEventListener(Event.COMPLETE, loadComplete);
			loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpResponse);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.removeEventListener(ProgressEvent.PROGRESS, progress);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			loader = null;
		}
	}

}