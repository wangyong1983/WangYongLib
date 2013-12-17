package org.wang.website.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SystemErrorEvent extends Event 
	{
		public static const ERROR:String = "system_error";
		private var _text:String;
		public function SystemErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
		}
		
	}

}