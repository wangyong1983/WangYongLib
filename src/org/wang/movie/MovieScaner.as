/**
* ...
* @author Default
* @version 0.1
*/

package org.wang.movie{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Rectangle;
	public class  MovieScaner extends EventDispatcher{
		private var stepX:Number = 5;
		private var stepY:Number = 5;
		private var rectAngle:Rectangle;
		private var target:DisplayObject;
		private var pointArr:Array;
		private var bitMapData:BitmapData;
		private var checkFun:Function;
		public function MovieScaner(tar:DisplayObject = null){
			bitMapData = new BitmapData(tar.width,tar.height,true,0x00000000);
			target = tar;
			bitMapData.draw(tar);
			pointArr = new Array();
			rectAngle = new Rectangle(0,0,target.width,target.height);
		}
		public function set checkFunction(fun:Function):void
		{
			checkFun = fun;
		}
		public function checkPoint(dot:int):Boolean{
			return checkFun(dot);
		}
		public function startScan(stepx:Number = 5,stepy:Number = 5,rect:Rectangle = null):void
		{
			rectAngle = rect;
			stepX = stepx;
			stepY = stepy;
			for(var tx:Number=rectAngle.x; tx<=rectAngle.width; tx+= stepX){
				for(var ty:Number = rectAngle.y; ty<=rectAngle.height; ty+=stepY){
					var dot:uint = bitMapData.getPixel(tx,ty);
					if(checkPoint(dot)){
						pointArr.push({x:tx,y:ty});
					}
				}
			}
			this.dispatchEvent(new Event(Event.COMPLETE))
		}
		public function get pointArray():Array{
			return pointArr;
		}
	}
	
}