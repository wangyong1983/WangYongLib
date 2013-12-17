package org.wang.utils 
{
	/**
	 * ...
	 * @author leo.wang
	 */
	public class CycleArray 
	{
		private var _array:Array;
		
		public function CycleArray(arr:Array = null) 
		{
			_array = arr?arr:[];
		}
		public function turnLeft(n:uint = 1 ):void
		{
			for (var i:int = 0; i < n; i++) 
			{
				_array.push(_array.shift());
			}
		}
		public function turnRight(n:uint = 1):void
		{
			for (var i:int = 0; i < n; i++) 
			{
				_array.unshift(_array.pop());
			}
		}
		
		public function get array():Array 
		{
			return _array;
		}
		public function get length():int
		{
			return _array.length;
		}
	}

}