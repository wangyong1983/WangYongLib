package org.wang.movie 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.wang.utils.EasyButton;

	

	public class EasyLockButton extends EasyButton
	{
		private static var _LOCK:Boolean;
		private static var buttonArr:Array;
		private static var ED:EventDispatcher = new EventDispatcher()
		public static const ON_LOCK:String = "ON_LOCK"
		public static function addEvtListener(type:String, listener:Function):void 	{  			
   			ED.addEventListener(type, listener);
   		}
		public static function removeEvtListener(type:String, listener:Function):void 	{  			
   			ED.removeEventListener(type, listener);
   		}
		public function EasyLockButton(mc:MovieClip) 
		{
			super(mc);
			init();
			//buttonArr.push(this);
		}
		private function init(e:Event = null):void {		
			addEventListener(Event.ADDED_TO_STAGE, _addListeners)
			addEventListener(Event.REMOVED_FROM_STAGE, _removeListeners)				
		}
		private function _addListeners(e:Event):void
		{	
			addEvtListener(ON_LOCK,_changeLock)			
		}
		private function _removeListeners(e:Event):void
		{			
			addEvtListener(ON_LOCK,_changeLock)
		}
		
		private function _changeLock():void
		{
			isLock = _LOCK;
		}
		static public function get LOCK():Boolean { return _LOCK; }
		
		static public function set LOCK(value:Boolean):void 
		{
			_LOCK = value;
			var evt:Event = new Event(ON_LOCK);
			ED.dispatchEvent(evt);
		}
	}
	
}
