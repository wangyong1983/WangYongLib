package org.wang.utils
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class TimeFormat
	{
		public function TimeFormat() {
			
		}
		//格式化秒，转成几小时几分几秒
		public static function formatSecondToChinese(num : uint) : String {
			///*
			var temp : String = "";
			if (num < 60) {
				temp = String(num + "秒");
			}else if (num >= 60 && num < 60 * 60) {
				temp = String(int(num/60) + "分") + num%60 + "秒";
			}else if (num >= 60 * 60) {
				var hour : int;
				var minute : int;
				var second : int;
				
				hour = int(num/3600);
				minute = int((num%3600)/60);
				second = int((num % 3600) % 60);
				temp = hour + "小时" + minute + "分" + second + "秒";
			}//*/
			return temp;
		}
		//格式化秒，转成几小时几分几秒 00:00:00
		public static function formatSecond(num : uint) : String {
			var hour : String;
			var minute : String;
			var second : String;
			var temp : String = "";
			if (num < 60) {
				second = String(int(num));
				if(int(second) < 10) second = "0" + second;
				temp = "00:" + second;
			}else if (num >= 60 && num < 60 * 60) {
				minute = String(int(num/60));
				second = String(int(num%60));
				if(int(minute) < 10) minute = "0" + minute;
				if(int(second) < 10) second = "0" + second;
				temp = String(minute + ":") + second;
			}else if (num >= 60 * 60) {
				hour = String(int(num/3600));
				minute = String(int((num%3600)/60));
				second = String(int((num % 3600) % 60));
				if(int(hour) < 10) hour = "0" + hour;
				if(int(minute) < 10) minute = "0" + minute;
				if(int(second) < 10) second = "0" + second;
				temp = hour + ":" + minute + ":" + second;
			}
			return temp;
		}
	}
	
}