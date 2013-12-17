package org.wang.math{
	import flash.geom.Point;
	public class EasyBeizer {
		private var point_arr:Array;
		public function EasyBeizer(arr:Array) {
			point_arr = arr;
		}
		public function getPoint(n:Number):Point {
			try {
				if (n<0 || n>1) {
					throw new Error("参数范围:0-1");
				}
			} catch (err:Error) {
				trace(err.message);
				return null;
			}
			return getBeizerPoint(point_arr,n);
		}
		public function getPointArray(m:uint):Array {
			var arr:Array = [];
			var n:Number = 1/m;
			for (var i:int=n; i<=1; i+=n) {
				arr.push(getBeizerPoint(point_arr,i));
			}
			return arr;
		}
		private function getBeizerPoint(arr:Array,per:Number):Point {
			var n:int = arr.length;
			switch (n) {
				case 0 :
					return null;
					break;
				case 1 :
					return arr[0];
					break;
				case 2 :
					return Point.interpolate(arr[0],arr[1],per);
					break;
				default :
					var new_arr:Array = [];
					for (var i:int=0; i<n-1; i++) {
						new_arr.push(Point.interpolate(arr[i],arr[i+1],per));
					}

					return getBeizerPoint(new_arr,per);
					break;
			}
		}
	}
}