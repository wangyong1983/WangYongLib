/**
* ...
* @author 网蛹
* @version 0.1
*/

package org.wang.event{
	import flash.events.Event;
	public class DynamicEvent extends Event{
		public var obj:Object;
		public function DynamicEvent(type:String):void {
			obj = new Object();
			super(type);
		}
	}
}