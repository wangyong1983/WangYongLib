package org.wang.movie
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author wang yong
	 */
	public class  TouchMovie extends EventDispatcher
	{
		private var _targetMovie:MovieClip;
		public function TouchMovie(mc:MovieClip) {
			_targetMovie = mc;
			//_targetMovie.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			_targetMovie.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			_targetMovie.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			if (_targetMovie.stage)
			{
				onAdded(null);
			}
			
		}
		
		private function onAdded(e:Event):void 
		{
			//removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_targetMovie.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		private function onRemoved(e:Event):void 
		{
			
			//_targetMovie.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			_targetMovie.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			//_targetMovie = null;
		}
		public function destory():void
		{
			//onRemoved(null);
			_targetMovie.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			_targetMovie.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_targetMovie.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_targetMovie = null;
		}
		private function onEnterFrame(e:Event):void 
		{
			//trace(_targetMovie.mouseX, _targetMovie.mouseY);
			var p:Point = new Point(_targetMovie.stage.mouseX, _targetMovie.stage.mouseY);
			//p = _targetMovie.localToGlobal(p);
			if (_targetMovie.hitTestPoint(p.x, p.y, true)) {
				_targetMovie.nextFrame();
			}else {
				_targetMovie.prevFrame();
			}
		}
		public function get targetMovie():MovieClip { return _targetMovie; }
	}
	
}