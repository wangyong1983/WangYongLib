package org.wang.compnents 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IScroll;
	import org.wang.view.BaseView;
	
	import org.wang.event.DynamicEvent;
	import org.wang.movie.DragMovie;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ScrollBar extends BaseView implements IScroll
	{
		private var _scrollSignal:Signal;
		private var _handleMovie:MovieClip;
		private var _distanceMovie:MovieClip;
		private var dragMovie:DragMovie;
		public function ScrollBar(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		
		private function init():void 
		{
			_scrollSignal = new Signal(Number, Number);
			_handleMovie = getChildMovieByName("_handle");
			_distanceMovie = getChildMovieByName("_distance");
			dragMovie = new DragMovie(_handleMovie, 0, 0, _distanceMovie.y, _distanceMovie.y + _distanceMovie.height - _handleMovie.height, false, true);
			dragMovie.addEventListener(DragMovie.MOUSE_DRAG, onDrag);
			
			view.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			view.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		protected function onRemove(event:Event):void
		{
			// TODO Auto-generated method stub
			dragMovie.mouseWhile = false;
		}
		
		protected function onAdded(event:Event):void
		{
			// TODO Auto-generated method stub
//			trace("mouseEnabled");
			dragMovie.mouseWhile = true;
		}
		public function setPosition(n:Number):void
		{
			dragMovie.perY = n;
		}
		private function onDrag(e:DynamicEvent):void 
		{
			_scrollSignal.dispatch(e.obj.x_per,e.obj.y_per);
		}
		public function get onScrollSignal():Signal
		{
			return _scrollSignal;
		}
	}

}