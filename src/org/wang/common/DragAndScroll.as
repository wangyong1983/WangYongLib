package org.wang.common 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import org.wang.compnents.ScrollBar;
	import org.wang.view.BaseView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class DragAndScroll extends BaseView 
	{
		private var scroll:ScrollBar;
		private var contentMovie:MovieClip;
		private var maskMovie:MovieClip;
		private var distance:Number;
		private var scrollMovie:MovieClip;
		public function DragAndScroll(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		private function init():void
		{
			scrollMovie = getChildMovieByName("_scroll");
			scroll = new ScrollBar(scrollMovie);
			scroll.onScrollSignal.add(onScroll);
			contentMovie = getChildMovieByName("_content");
			maskMovie = getChildMovieByName("_mask");
			contentMovie.mask = maskMovie;
			fresh();
			//view.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		private function onScroll(x:Number,y:Number):void 
		{
			contentMovie.y = -distance * y + maskMovie.y;
		}
		public function fresh():void
		{
			distance = contentMovie.height - maskMovie.height;
			if (distance <= 0)
			{
				scroll.view.visible = false;
			}else
			{
				scroll.view.visible = true;
			}
		}
	}

}