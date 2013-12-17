package org.wang.website.event 
{
	import org.osflash.signals.events.IEvent;
	import org.osflash.signals.IPrioritySignal;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class PageEvent extends Object
	{
		public static const PAGE_INIT:String = "page_init";
		public static const PAGE_JOIN_READY:String = "page_join_ready";
		public static const PAGE_JOIN_DONE:String = "page_join_done";
		public static const PAGE_OUT_READY:String = "page_out_ready";
		public static const PAGE_OUT_DONE:String = "page_out_done";
		private var _type:String;
		private var _bubbles:Boolean;
		private var _currentTarget:Object;
		private var _signal:ISignal;
		private var _target:Object;
		public function PageEvent(s:String) 
		{
			super();
			_type = s;
			_bubbles = true;
		}
		
		
		public function get bubbles():Boolean 
		{
			return _bubbles;
		}
		
		public function set bubbles(value:Boolean):void 
		{
			_bubbles = value;
		}
		
		public function clone():PageEvent 
		{
			return new PageEvent(_type);
		}
		
		public function get currentTarget():Object 
		{
			return _currentTarget;
		}
		
		public function set currentTarget(value:Object):void 
		{
			_currentTarget = value;
		}
		
		public function get signal():ISignal 
		{
			return _signal;
		}
		
		public function set signal(value:ISignal):void 
		{
			_signal = value;
		}
		
		public function get target():Object 
		{
			return _target;
		}
		
		public function set target(value:Object):void 
		{
			_target = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
	}

}