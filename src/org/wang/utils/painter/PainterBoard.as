package org.wang.utils.painter 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.wang.interfaces.IBrush;
	import org.wang.interfaces.IPainterBoard;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class PainterBoard implements IPainterBoard
	{
		private var _width:Number;
		private var _height:Number;
		private var paintingBitmapData:BitmapData;
		private var paintingBitmap:Bitmap;
		private var _view:Sprite;
		private var maxb:Number;
		private var minb:Number;
		private var step:Number;
		private var pdis:Number;
		private var pbold:Number;
		private var nowstep:int;
		private var _brush:IBrush;
		public function PainterBoard(w:Number,h:Number) 
		{
			_width = w;
			_height = h;
			paintingBitmapData = new BitmapData(w, h, true, 0);
			paintingBitmap = new Bitmap(paintingBitmapData, "auto", true);
			_view = new Sprite();
			_view.addChild(paintingBitmap);
			_view.cacheAsBitmap = true;
			
			maxb = 5;
			minb = 1;
			step = 10;
			pdis = 5;
			pbold = 1;
			nowstep = 0;
		}
		/*此数值越大,点的大小过度越平滑*/
		public function set fillDistance(n:Number):void
		{
			pdis = n;
		}
		/*笔画缩放值 默认为1,最小0.1,最大5*/
		public function set bolderScale(n:Number):void
		{
			n = n < 0?0.1:n;
			n = n > 5?5:n;
			pbold = n;
		}
		/*笔画最小值*/
		public function set minBolder(n:Number):void
		{
			minb = n;
		}
		public function drawDot(p:Point):void
		{
			//画点 图章
			var mymat:Matrix = new Matrix();
			mymat.scale(pbold, pbold); 
			mymat.translate(p.x-brush.brush.width*.5, p.y-brush.brush.height*.5);
			paintingBitmapData.draw(brush.brush, mymat, null, null, null, true); 
		}
		public function drawLine(p1:Point, p2:Point,autoFill:Boolean = true):void
		{
			//画线
			paintingBitmapData.lock();
			var dis:Number = Point.distance(p1, p2);
			var dw:Number = minb + nowstep * pbold;
			var edw:Number = dw;
			if (dis > pdis) {
				var dn:Number = Math.ceil(dis / pdis);
				nowstep = Math.min(step, Math.max(0, nowstep - dn));
				edw = minb +  nowstep* pbold;
			}else if(dis<pdis){
				nowstep = Math.min(step, Math.max(0, nowstep +1));
				edw = minb +  nowstep* pbold;
			}
			var tPoint:Point = p1.clone();
			var tw:Number = dw;
			var lenw:Number = edw - dw;
			
			var nl:Number = Point.distance(tPoint, p1);
			//缩放比例有待调整
			if (autoFill)
			{
				while(nl<dis){
					var w:Number = tw * .10;
					var mymat:Matrix = new Matrix();
					mymat.scale(tw / brush.brush.width, tw / brush.brush.width); 
					mymat.translate(tPoint.x-tw*.5, tPoint.y-tw*.5);
					paintingBitmapData.draw(brush.brush, mymat, null, null, null, true); 
					var tds:Number = Point.distance(tPoint, p1) + w;
					tPoint.x = p1.x + tds * (p2.x - p1.x) / dis;
					tPoint.y = p1.y + tds * (p2.y - p1.y) / dis;
					nl = Point.distance(tPoint, p1);
					tw = nl/dis * lenw + dw;
				}
			}
			else
			{
				var mymat2:Matrix = new Matrix();
				mymat2.scale(tw / brush.brush.width, tw / brush.brush.width); 
				mymat2.translate(tPoint.x-tw*.5, tPoint.y-tw*.5);
				//mymat.translate(tPoint.x, tPoint.y);
				paintingBitmapData.draw(brush.brush, mymat2, null, null, null, true); 
			}
			paintingBitmapData.unlock();
		}
		public function clearUp():void
		{
			//清除
			paintingBitmapData = new BitmapData(_width, _height, true, 0);
			paintingBitmap.bitmapData = paintingBitmapData;
			//paintingBitmap = new Bitmap(paintingBitmapData, "auto", true);
		}
		
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function get view():Sprite 
		{
			return _view;
		}
		public function get painting():BitmapData
		{
			return paintingBitmapData;
		}
		
		public function get brush():IBrush 
		{
			return _brush;
		}
		
		public function set brush(value:IBrush):void 
		{
			_brush = value;
			maxb = _brush.brush.width;
		}
	}

}