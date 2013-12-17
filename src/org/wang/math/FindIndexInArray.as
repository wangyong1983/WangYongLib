package org.wang.math
{
		public function FindIndexInArray(n:*,arr:Array):int
		{
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				if(arr[i] == n)
				{
					return i;
				}
			}
			return -1;
		}
}