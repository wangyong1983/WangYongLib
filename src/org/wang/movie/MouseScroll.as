package org.wang.movie
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class MouseScroll 
	{
		private var _speed:Number;
		private var movie:DisplayObjectContainer;
		private var _left:Number;
		private var _right:Number;
		private var _up:Number;
		private var _down:Number;
		private var perX:Number;
		private var perY:Number;
		private var _lockX:Boolean = true;
		private var _lockY:Boolean = true;
		public static var minStep:Number = 0.01;
		public function MouseScroll(mc:DisplayObjectContainer) 
		{
			movie = mc;
			_speed = 3;
			movie.addEventListener(Event.ENTER_FRAME, onEnterMove,false,0,true);
		}
		public function moveX(per:Number):void
		{
			perX = Math.min(per, 1);
			perX = Math.max(per, 0);
		}
		public function moveY(per:Number):void
		{
			perX = Math.min(per, 1);
			perX = Math.max(per, 0);
		}
		private function onEnterMove(e:Event):void 
		{
			if (_lockX) {
				var targetX:Number = (_right - _left) * perX + _left;
				var moveX:Number = (targetX - movie.x) / speed;
				if(Math.abs(moveX)>minStep){
					movie.x += moveX;
				}else {
					movie.x = targetX;
				}
			}
			if(_lockY){
				var targetY:Number = (_down - _up) * perX + _up;
				var moveY:Number = (targetY - movie.y) / speed;
				if(Math.abs(moveY)>minStep){
					movie.y += moveY;
				}else {
					movie.y = targetY;
				}
			}
			
		}
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get left():Number 
		{
			return _left;
		}
		
		public function set left(value:Number):void 
		{
			_left = value;
		}
		
		public function get right():Number 
		{
			return _right;
		}
		
		public function set right(value:Number):void 
		{
			_right = value;
		}
		
		public function get up():Number 
		{
			return _up;
		}
		
		public function set up(value:Number):void 
		{
			_up = value;
		}
		
		public function get down():Number 
		{
			return _down;
		}
		
		public function set down(value:Number):void 
		{
			_down = value;
		}
		
		public function get lockX():Boolean 
		{
			return _lockX;
		}
		
		public function set lockX(value:Boolean):void 
		{
			_lockX = value;
		}
		
		public function get lockY():Boolean 
		{
			return _lockY;
		}
		
		public function set lockY(value:Boolean):void 
		{
			_lockY = value;
		}
	}
}
