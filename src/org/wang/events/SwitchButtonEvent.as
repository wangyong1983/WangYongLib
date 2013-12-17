package org.wang.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author wang yong
	 */
	public class  SwitchButtonEvent extends Event
	{
		public static const SWITCH_CLICK:String = "switchclick";
		private var _switchFrame:int;
		public function SwitchButtonEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function get switchFrame():int { return _switchFrame; }
		
		public function set switchFrame(value:int):void 
		{
			_switchFrame = value;
		}
	}
	
}