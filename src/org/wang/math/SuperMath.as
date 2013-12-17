package org.wang.math{
	import flash.geom.Point;
	import flash.display.MovieClip;
	public class SuperMath {
		public static  var showerror:Boolean = true;
		public static function set showError(b:Boolean):void {
			showerror = b;
		}
		public static function throwError(s:String):void {
			if (showerror) {
				trace(s);
			}
		}
		public function SuperMath() {

		}
		//获得弧度
		public static function getRadians(n:Number):Number {
			return n * Math.PI / 180;
		}
		//获得角度
		public static function getDegrees(n:Number):Number {
			return n * 180 / Math.PI;
		}
		/*在直角三角形中,一个角的余弦等于另一个角的正弦,反之亦然.*/

		//获得正弦 第二个参数为True则参数N表示弧度,反之则为度.
		//正弦表示一个角的对边与斜边的比值.
		public static function getSin(n:Number,b:Boolean):Number {
			if (b) {
				return Math.sin(n);
			} else {
				return Math.sin(getRadians(n));
			}
		}
		//获得余弦 第二个参数为True则参数N表示弧度,反之则为度.
		//余弦表示一个角的临边与斜边的比值.
		public static function getCos(n:Number,b:Boolean):Number {
			if (b) {
				return Math.cos(n);
			} else {
				return Math.cos(getRadians(n));
			}
		}
		//获得正切 第二个参数为True则参数N表示弧度,反之则为度.
		//正切表示对边与临边的比值.
		public static function getTan(n:Number,b:Boolean):Number {
			if (b) {
				return Math.tan(n);
			} else {
				return Math.tan(getRadians(n));
			}
		}
		//获得反正切 不分像限 如果需要返回弧度,则参数b为True,如需返回角度,则b为False.
		//反正切是正切的逆,只要提供对边与临边的比例,就会得到那个角度.
		public static function getAtan(n:Number,b:Boolean):Number {
			if (b) {
				return Math.atan(n);
			} else {
				return getDegrees(Math.atan(n));
			}
		}
		//反正切 分像限 如果需要返回弧度,则参数b为True,如需返回角度,则b为False.
		public static function getAtan2(y:Number,x:Number,b:Boolean):Number {
			if (b) {
				return Math.atan2(y,x);
			} else {
				return getDegrees(Math.atan2(y,x));
			}
		}
		//反正切 参数为两个Point实例. 如果需要返回弧度,则参数b为True,如需返回角度,则b为False.
		public static function getAtan2_p(p1:Point,p2:Point,b:Boolean):Number {
			if (b) {
				return Math.atan2(p2.y - p1.y,p2.x - p1.x);
			} else {
				return getDegrees(Math.atan2(p2.y - p1.y,p2.x - p1.x));
			}
		}
		//反正切 参数为两个MovieClip实例. 如果需要返回弧度,则参数b为True,如需返回角度,则b为False.
		public static function getAtan2_m(p1:MovieClip,p2:MovieClip,b:Boolean):Number {
			if (b) {
				return Math.atan2(p2.y - p1.y,p2.x - p1.x);
			} else {
				return getDegrees(Math.atan2(p2.y - p1.y,p2.x - p1.x));
			}
		}
	}
}