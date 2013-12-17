/**
* ...
* @author 网蛹
* @version 0.1
*/

package org.wang.events{
	import flash.events.Event;
	public class EasyMenuEvent extends Event{
		public var targetButton:*;
		public static const ROLL_OVER:String = "eme_rollOver";
		public static const ROLL_OUT:String = "eme_rollOut";
		public static const CLICK:String = "eme_click";
		public function EasyMenuEvent(type:String):void {
			super(type);
		}
	}
}