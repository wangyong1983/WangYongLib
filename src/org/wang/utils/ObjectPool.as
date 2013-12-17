package org.wang.utils
{

	public class ObjectPool
	{
		private var pool:Array;
		public function ObjectPool() 
		{
			pool = [];
		}
		public function addObject(o:*):void{
			pool.push(o);
		}
		public function getObject():*{
			if(pool.length<=0) return null
			return pool.pop();
		}
		public function hasObject():Boolean
		{
			return Boolean(pool.length);
		}
	}
}