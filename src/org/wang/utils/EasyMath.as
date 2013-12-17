package org.wang.utils 
{
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyMath 
	{
		
		public function EasyMath() 
		{
			
		}
		public static function random(left:Number = 0, right:Number = 100):Number
		{
			var min:Number = Math.min(left, right);
			var max:Number = Math.max(left, right);
			return Math.random() * (max - min) + min;
		}
	}

}