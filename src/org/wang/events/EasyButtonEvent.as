package org.wang.events
{
	import flash.events.Event;
	
	public class EasyButtonEvent extends Event
	{
		public static const ROLL_OVER:String = "ebe_rollOver";
		public static const ROLL_OUT:String = "ebe_rollOut";
		public static const CLICK:String = "ebe_click";
		public function EasyButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}