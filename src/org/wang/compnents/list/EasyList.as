package org.wang.compnents.list 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.wang.event.DynamicEvent;
	import org.wang.movie.DragMovie;
	import org.wang.view.BaseView;
	
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyList extends BaseView 
	{
		private var sitckMovie:MovieClip;
		private var dragMovie:MovieClip;
		private var bgMovie:MovieClip;
		private var dragButton:DragMovie;
		private var listContainer:Sprite;
		private var _mask:MovieClip;
		private var _length:int;
		private var dragDistance:Number;
		private var targetArr:Array;
		public function EasyList(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		
		private function init():void 
		{
			sitckMovie = getChildMovieByName("_stick");
			dragMovie = getChildMovieByName("_drag");
			bgMovie = getChildMovieByName("_bg");
			_mask = getChildMovieByName("_mask");
			targetArr = [];
			_length = 0;
			dragDistance = 0;
			dragButton = new DragMovie(dragMovie, 0, 0, 0, sitckMovie.height - dragMovie.height, false, true);
			dragButton.addEventListener("MOUSE_DRAG", onDrag);
			listContainer = new Sprite();
			view.addChildAt(listContainer,1);
			_mask.width = bgMovie.width;
			_mask.height = bgMovie.height;
			listContainer.mask = _mask;
			//_mask.alpha = 0;
		}
		public function set mouseWheelEnabled(b:Boolean):void
		{
			dragButton.mouseWhile = b;
		}
		public function clear():void
		{
			while (listContainer.numChildren)
			{
				listContainer.removeChildAt(0);
			}
			dragDistance = 0;
			_length = 0;
			targetArr = [];
		}
		public function getElementByID(n:int):DisplayObject
		{
			if (n > targetArr.length)
			{
				return null;
			}
			return targetArr[n] as DisplayObject;
		}
		public function add(mc:DisplayObject,distance:Number = 0):void
		{
			mc.y = listContainer.height + distance;
			mc.x = 0;
			listContainer.addChild(mc);
			_length++;
			dragDistance = bgMovie.height - listContainer.height;
			targetArr.push(mc);
		}
		private function onDrag(e:DynamicEvent):void 
		{
			if (dragDistance >= 0)
			{
				return;
			}
			listContainer.y = dragDistance * e.obj.y_per;
		}
		
		public function get length():int 
		{
			return _length;
		}
	}

}