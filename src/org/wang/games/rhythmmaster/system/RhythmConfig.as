package org.wang.games.rhythmmaster.system
{
	public class RhythmConfig
	{
		static private var _advanceTime:uint = 3000;
		static private var _rate:uint = 1;
		
		static private var _maxCheckTime:uint = 200;
		
		static private var _missTime:uint = 100;
		
		static private var _holdInterval:uint = 100;
		
		public function RhythmConfig()
		{
			
		}

		public static function get advanceTime():uint
		{
			return _advanceTime;
		}
		/**
		 * 
		 * @param 提前量 数据提前多长时间放入队列等待触发 通常该值用来计算触发器画面何时加入场景开始滑动.
		 * 
		 */
		public static function set advanceTime(value:uint):void
		{
			_advanceTime = value;
		}

		public static function get rate():uint
		{
			return _rate;
		}
		/**
		 * 
		 * @param 倍速
		 * 
		 */
		public static function set rate(value:uint):void
		{
			_rate = value;
		}

		public static function get maxCheckTime():uint
		{
			return _maxCheckTime;
		}
		/**
		 * 
		 * @param 最大检测时间, 当触发时间和数据差值小于该值时即开始判定. 大于该值时不算触发
		 * 
		 */
		public static function set maxCheckTime(value:uint):void
		{
			_maxCheckTime = value;
		}

		public static function get missTime():uint
		{
			return _missTime;
		}
		/**
		 * 
		 * @param 失败时间  超过该值即为Miss
		 * 
		 */
		public static function set missTime(value:uint):void
		{
			_missTime = value;
		}

		public static function get holdInterval():uint
		{
			return _holdInterval;
		}
		/**
		 * 
		 * @param 持续按下时,检测间隔
		 * 
		 */		
		public static function set holdInterval(value:uint):void
		{
			_holdInterval = value;
		}


	}
}