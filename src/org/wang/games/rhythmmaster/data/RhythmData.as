package org.wang.games.rhythmmaster.data
{
	import org.wang.games.rhythmmaster.interfaces.IRhythmData;

	public class RhythmData implements IRhythmData
	{

		private var _type:String;

		private var _time:uint;
		
		private var _holdTime:uint;
		static public const TAP:String = "tap";
		static public const HOLD:String = "hold";
		public function RhythmData(type:String = TAP,time:uint = 0,holdtime:uint = 0)
		{
			_type = type;
			_time = time;
			_holdTime = holdtime;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get time():uint
		{
			return _time;
		}

		public function set time(value:uint):void
		{
			_time = value;
		}

		public function get holdTime():uint
		{
			return _holdTime;
		}

		public function set holdTime(value:uint):void
		{
			_holdTime = value;
		}


	}
}