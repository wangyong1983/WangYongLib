package org.wang.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	//
	public class BitMapMovieClip
	{
		private var _view:MovieClip;
		
		private var bitmapVector:Vector.<BitmapData>;
		private var _movie:Bitmap;
		private var rectAngle:Rectangle;
		private var _smooth:Boolean;
		private var _currFrame:int;
		private var _totalFrames:int;
		//private var eventDispatcher:EventDispatcher;
		public function BitMapMovieClip(v:MovieClip,auto:Boolean = true,rect:Rectangle = null)
		{
			_view = v;
			_view.stop();
			_smooth = true;
			if(rect)
			{
				rectAngle = rect;
			}else
			{
				rectAngle = v.getRect(v);
			}
			if(v && auto)
			{
				createBuffer();
			}
		}

		public function get smooth():Boolean
		{
			return _smooth;
		}

		public function set smooth(value:Boolean):void
		{
			_smooth = value;
		}
		public function gotoAndStop(frame:int):void
		{
			currFrame = frame;
			_movie.bitmapData = bitmapVector[_currFrame];
		}
		public function gotoAndPlay(frame:int):void
		{
			currFrame = frame;
			play();
		}
		public function play():void
		{
			_view.addEventListener(Event.ENTER_FRAME,onPlay);
		}
		public function stop():void
		{
			_view.removeEventListener(Event.ENTER_FRAME,onPlay);
		}
		private function onPlay():void
		{
			_movie.bitmapData = bitmapVector[_currFrame];
			currFrame++;
			currFrame %= _totalFrames;
		}
		public function createBuffer():void
		{
			
			_totalFrames = _view.totalFrames;
			bitmapVector = new Vector.<BitmapData>(_totalFrames);
			for(var i:int = 0;i<_totalFrames;i++)
			{
				_view.gotoAndStop(i+1);
				bitmapVector[i] = new BitmapData(rectAngle.width,rectAngle.height,true,0);
				BitmapData(bitmapVector[i]).draw(_view,null,null,null,null,true);
			}
			_movie = new Bitmap(bitmapVector[0],"auto",_smooth);
		}

		public function get movie():Bitmap
		{
			return _movie;
		}

		public function get currFrame():int
		{
			return _currFrame + 1;
		}

		public function set currFrame(value:int):void
		{
			_currFrame = value - 1;
		}


	}
}