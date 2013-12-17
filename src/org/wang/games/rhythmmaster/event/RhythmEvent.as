package org.wang.games.rhythmmaster.event
{
	import flash.events.Event;
	
	public class RhythmEvent extends Event
	{
		public static const CALCULATE:String = "rhythm_event_calculate";
//		private var _level:uint;
		private var _timeDetail:uint;
		private var _miss:Boolean;
		public function RhythmEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_miss = false;
		}

//		public function get level():uint
//		{
//			return _level;
//		}
//
//		public function set level(value:uint):void
//		{
//			_level = value;
//		}

		public function get timeDetail():uint
		{
			return _timeDetail;
		}

		public function set timeDetail(value:uint):void
		{
			_timeDetail = value;
		}

		public function get miss():Boolean
		{
			return _miss;
		}

		public function set miss(value:Boolean):void
		{
			_miss = value;
		}


	}
}