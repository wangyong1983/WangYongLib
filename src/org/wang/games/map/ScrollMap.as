package org.wang.games.map 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IIterator;
	import org.wang.interfaces.IScrollMapDot;
	import org.wang.view.BaseView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ScrollMap
	{
		private var _width:Number;
		private var _height:Number;
		private var _rect:Rectangle;
		private var _dotArr:Array
		private var upDataSignal:Signal;
		private var disWidth:Number;
		private var disHeight:Number;
		private var len:int;
		public function ScrollMap(width:Number,height:Number) 
		{
			_width = width;
			_height = height;
			upDataSignal = new Signal();
			_dotArr = new Array();
		}
		public function move(p:Point):void
		{
			//trace("-------------------move");
			_rect.x += p.x;
			_rect.y += p.y;
			/*
			_rect.x = _rect.x < 0 ? 0:_rect.x;
			_rect.x = _rect.x > (width - _rect.width) ? width - _rect.width:_rect.x;
			_rect.y = _rect.y < 0 ? 0:_rect.y;
			_rect.y = _rect.y > (height - _rect.height) ? height - _rect.height:_rect.y;
			*/
			//trace(_rect, width, height);
			_rect.x = (_rect.x + width) % _width;
			_rect.y = (_rect.y + height) % _height;
			_reFresh();
		}
		public function moveTo(p:Point):void
		{
			_rect.x = p.x;
			_rect.y = p.y;
			_rect.x = (_rect.x + width) % _width;
			_rect.y = (_rect.y + height) % _height;
			_reFresh();
		}
		public function reFresh():void
		{
			_reFresh();
		}
		private function checkRect(rect:Rectangle):Boolean
		{
			// 325 260
			if (!rect.intersects(_rect))
			{
				return false;
			}
			return true;
			//return rect.intersects(_rect) && !rect.intersects(otherRect);
		}
		private function _reFresh():void 
		{
			
			for (var i:int = 0; i < len; i++) 
			{
				var dot:IScrollMapDot = _dotArr[i] as IScrollMapDot;
				dot.show = false;
				//dot.view.visible = false;
				if (checkRect(dot.rect))
				{
					dot.show = true;
					dot.x = dot.rect.x - _rect.x;
					dot.y = dot.rect.y - _rect.y;
				}
				if (_rect.x > disWidth && _rect.y > disHeight)
				{
					var orx:Number = _rect.x;
					var ory:Number = _rect.y;
					_rect.x = orx - width;
					_rect.y = ory - height;
					if (checkRect(dot.rect))
					{
						dot.show = true;
						dot.x = dot.rect.x - _rect.x;
						dot.y = dot.rect.y - _rect.y;
					}
					_rect.x = orx;
					_rect.y = ory;
				}
				if (_rect.x > disWidth)
				{
					var ox:Number = _rect.x;
					_rect.x = ox - width;
					if (checkRect(dot.rect))
					{
						dot.show = true;
						dot.view.x = dot.rect.x - _rect.x;
						dot.view.y = dot.rect.y - _rect.y;
					}
					_rect.x = ox;
				}
				if (_rect.y > disHeight)
				{
					var oy:Number = _rect.y;
					_rect.y = oy - height;
					if (checkRect(dot.rect))
					{
						dot.show = true;
						dot.view.x = dot.rect.x - _rect.x;
						dot.view.y = dot.rect.y - _rect.y;
					}
					_rect.y = oy;
				}
			}
			
		}
		public function set width(value:Number):void 
		{
			_width = value;
		}
		public function get width():Number 
		{
			return _width;
		}
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function get viewRect():Rectangle 
		{
			return _rect;
		}
		
		public function set viewRect(value:Rectangle):void 
		{
			_rect = value;
			disWidth = width - _rect.width;
			disHeight = height - _rect.height;
		}
		
		public function get dotArr():Array
		{
			return _dotArr;
		}
		
		public function set dotArr(arr:Array):void 
		{
			_dotArr = arr;
			len = _dotArr.length;
		}
		
	}

}