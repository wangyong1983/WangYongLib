package org.wang.core 
{
	import org.wang.interfaces.IIterator;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseVOList
	{
		private var voList:Vector.<BaseVO>;
		private var curr:int;
		private var _length:int;
		public function BaseVOList() 
		{
			voList = new Vector.<BaseVO>;
			curr = 0;
		}
		public function addVO(b:BaseVO):void
		{
			voList.push(b);
			_length = voList.length;
		}
		public function getVOByID(n:int):BaseVO
		{
			return voList[n];
		}
		public function get length():int 
		{
			return _length;
		}
	}

}