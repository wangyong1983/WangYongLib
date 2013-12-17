package org.wang.utils.painter 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import org.wang.interfaces.IBrush;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class CircleBrush implements IBrush 
	{
		private var _brush:BitmapData;
		private var _color:uint;
		private var _radius:Number;
		private var _alpha:Number;
		private var container:Sprite;
		public function CircleBrush(c:uint = 0x000000,r:Number = 3,a:Number = 1) 
		{
			_color = c;
			_radius = r;
			_alpha = a;
			container = new Sprite();
			createBrush();
		}
		
		private function createBrush():void 
		{
			container.graphics.clear();
			container.graphics.beginFill(_color, _alpha);
			container.graphics.drawCircle(0, 0, _radius);
			container.graphics.endFill();
			_brush = new BitmapData(container.width, container.height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.translate(_radius, _radius);
			_brush.draw(container, matrix, null, null, null, true);
		}
		
		/* INTERFACE org.wang.interfaces.IBrush */
		
		public function get brush():BitmapData 
		{
			return _brush;
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
			createBrush();
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
			createBrush();
		}
		
		public function get alpha():Number 
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void 
		{
			_alpha = value;
			createBrush();
		}
		
	}

}