package org.wang.math
{
		public function FillZeroInNumber(n:int,len:int):String
		{
			var str:String = String(n);
			var l:int = len-str.length;
			for (var i:int = 0; i < l; i++) 
			{
				str = "0"+str;
			}
			return str;
		}
}