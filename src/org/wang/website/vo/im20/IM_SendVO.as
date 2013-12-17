package org.wang.website.vo.im20 
{
	
	import flash.net.URLVariables;
	
	import ghostcat.util.encrypt.MD5;
	
	import org.wang.website.vo.BaseSendVO;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class IM_SendVO extends BaseSendVO 
	{
		public static const SECURE_CODE:String = "2uVQ2yxMpQ1ROfbG";
		public static const FLASH_SECURE_CODE:String = "R5a39A0dK3c66O4Z";
		private var _rnd:String;
		private var _mdk:String;
		public function IM_SendVO() 
		{
			super();
			
		}
		override public function getVariables():URLVariables
		{
			var urlVariables:URLVariables = new URLVariables();
			var data:Date = new Date();
			//dataObj.rnd = int(getTimer()/1000);
			dataObj.rnd = data.getTime();
			for (var name:String in dataObj) 
			{
				urlVariables[name] = dataObj[name];
			}
			urlVariables.mdk = mdk;
			return urlVariables;
		}
		protected function get mdk():String 
		{
			var arr:Array = [];
			for (var name:String in dataObj) 
			{
				arr.push(name);
			}
			arr = arr.sort();
			var len:int = arr.length;
			var str:String = "";
			for (var i:int = 0; i < len; i++) 
			{
				str += dataObj[arr[i]] + "_";
			}
			str += FLASH_SECURE_CODE;
			//trace(str);
			_mdk = MD5.getMd5(str);
			return _mdk;
		}
	}

}