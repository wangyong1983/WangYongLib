package org.wang.core 
{
	import org.wang.interfaces.IIterator;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ArrayIterator implements IIterator 
	{
		private var _dataArr:Array;
		private var _cursor:int;
		public function ArrayIterator(arr:Array) 
		{
			_dataArr = arr;
			_cursor = 0;
		}
		
		/* INTERFACE org.wang.interfaces.IIterator */
		
		public function reset():void 
		{
			_cursor = 0;
		}
		
		public function get hasNext():Boolean 
		{
			return _cursor < _dataArr.length;
		}
		
		public function get next():Object 
		{
			
			return _dataArr[_cursor++];
		}
		
	}

}