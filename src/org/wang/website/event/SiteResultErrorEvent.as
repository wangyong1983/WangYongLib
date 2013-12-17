package org.wang.website.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SiteResultErrorEvent extends Event 
	{
		public static const ERROR:String = "site_result_error";
		private var _text:String;
		public function SiteResultErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
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