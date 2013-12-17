package org.wang.utils 
{
	import flash.display.Sprite;
	import flash.geom.Point;

	

	public class DrawSector extends Sprite
	{
		private var _circleCenter:Point = new Point(); //圆心
		private var _radius:Number = 100;//半径
		private var _color:uint = 0xff0000;
		private var _angle:Number = 30; //默认角度
		private var _startFrom:Number = 0; //默认起始角度
		function DrawSector():void {
			reDraw();
		}
		public function reFresh():void {
			reDraw();
		}
		private function reDraw():void {
			this.graphics.clear();
			this.graphics.beginFill(_color, 1);
			var x:Number = _circleCenter.x;
			var y:Number = _circleCenter.y;
			var r:Number = _radius;
			//remove this line to unfill the sector
			/* the border of the secetor with color 0xff0000 (red) , you could replace it with any color 
			* you want like 0x00ff00(green) or 0x0000ff (blue).
			*/
			this.graphics.lineStyle(0,0xff0000);
			this.graphics.moveTo(x,y);
			var s_angle:Number=(Math.abs(_angle)>360)?360:_angle;
			var n:Number=Math.ceil(Math.abs(s_angle)/45);
			var angleA:Number=s_angle/n;
			angleA=angleA*Math.PI/180;
			var s_startFrom:Number=startFrom*Math.PI/180;
			this.graphics.lineTo(x+r*Math.cos(s_startFrom),y+r*Math.sin(s_startFrom));
			for (var i:int=1; i<=n; i++) {
				s_startFrom+=angleA;
				var angleMid:Number=s_startFrom-angleA/2;
				var bx:Number=x+r/Math.cos(angleA/2)*Math.cos(angleMid);
				var by:Number=y+r/Math.cos(angleA/2)*Math.sin(angleMid);
				var cx:Number=x+r*Math.cos(s_startFrom);
				var cy:Number=y+r*Math.sin(s_startFrom);
				this.graphics.curveTo(bx,by,cx,cy);
			}
			if (s_angle!=360) {
				this.graphics.lineTo(x,y);
			}
			this.graphics.endFill();// if you want a sector without filling color , please remove this line.
		}
		public function set circleCenter(value:Point):void 
		{
			_circleCenter = value;
		}
		public function get circleCenter():Point { return _circleCenter; }
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get color():uint { return _color; }
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function get angle():Number { return _angle; }
		
		public function set angle(value:Number):void 
		{
			_angle = value;
		}
		
		public function get startFrom():Number { return _startFrom; }
		
		public function set startFrom(value:Number):void 
		{
			_startFrom = value;
		}
		
		
		
	}
	
}
