package org.wang.website.vo 
{
	import flash.net.URLVariables;
	import org.wang.core.BaseVO;
	import flash.utils.getTimer;
	import org.wang.website.interfaces.ISendVO;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseSendVO extends BaseVO implements ISendVO
	{
		public static var NO_CACHE:Boolean = false;
		protected var dataObj:Object;
		
		public function BaseSendVO() 
		{
			super();
			dataObj = new Object();
		}
		public function getObject():Object
		{
			return dataObj;
		}
		public function getVariables():URLVariables
		{
			var urlVariables:URLVariables = new URLVariables();
			if (NO_CACHE)
			{
				var data:Date = new Date();
				dataObj.rnd = data.getTime();
			}
			
			for (var name:String in dataObj) 
			{
				urlVariables[name] = dataObj[name];
			}
			return urlVariables;
		}
		public function addValue(key:String, value:*):void
		{
			dataObj[key] = value;
		}
		
	}

}