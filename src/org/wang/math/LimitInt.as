package org.wang.math 
{
	/**
	 * ...
	 * @author leo.wang
	 */
	public class LimitInt 
	{
		private var _value:int;
		private var len:int;
		private var _max:int;
		private var _min:int;
		public function LimitInt(max:int,min:int = 0) 
		{
			_value = min;
			len = max - min;
			_max = max;
			_min = min;
		}
		
		public function get value():int 
		{
			return _value;
		}
		public function plus(n:int):int
		{
			value += n;
			return _value;
		}
		public function minus(n:int):int
		{
			value -= n;
			return _value;
		}
		public function set value(value:int):void 
		{
			_value = (value + (uint(value) % len + 1) * len) % len + _min;
		}
		
		public function get min():int 
		{
			return _min;
		}
		
		public function set min(value:int):void 
		{
			_min = value;
		}
		
		public function get max():int 
		{
			return _max;
		}
		
		public function set max(value:int):void 
		{
			_max = value;
		}
		
	}

}