/**
* ...
* @author 网蛹
* @version 0.1
*/
package org.wang.event{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	public class MovieEvent extends Event {
		public static  var PLAY_PROGRESS:String = "playProgress";
		public static  var _dispatcher:EventDispatcher;
		public var mc_Target:MovieClip;
		public function MovieEvent(type:String):void {
			super(type);
		}
		static public function get Dispatcher():EventDispatcher {
			_dispatcher=_dispatcher == null?new EventDispatcher()  :_dispatcher;
			return _dispatcher;
		}
	}

}