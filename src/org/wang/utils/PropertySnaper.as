package org.wang.utils 
{
	/**
	 * ...
	 * @author leo.wang
	 */
	public class PropertySnaper extends Object 
	{
		private var properyList:Array
		private var data:Object;
		public function PropertySnaper(arr:Array = null) 
		{
			properyList = arr?arr:[];
		}
		public function addPropery(s:String):PropertySnaper
		{
			properyList.push(s);
			return this;
		}
		public function get snapData():Object
		{
			return data;
		}
		public function restoration(s:Object):*
		{
			for (var name:String in data) 
			{
				s[name] = data[name];
			}
			return s;
		}
		public function snap(s:*):Object
		{
			data = new Object();
			var len:int = properyList.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (s[properyList[i]] != null)
				{
					data[properyList[i]] = s[properyList[i]];
				}
			}
			return data;
		}
	}

}