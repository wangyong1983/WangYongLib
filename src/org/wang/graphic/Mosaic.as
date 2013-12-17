/**
* ...
* @author Default
* @version 0.1
*/

package org.wang.graphic{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;

	public class Mosaic extends EventDispatcher{
		private var blockWidth:uint;
		private var blockHeight:uint;
		private var bmd:BitmapData;
		private var drawTarget:DisplayObject;
		private var matrix:Matrix;
		private var isActive:Boolean;
		private var _bitMap:Bitmap;
		public function Mosaic(dsp:DisplayObject,block:uint = 20,active:Boolean = false){
			super();
			//trace(dsp)
			isActive = active;
			drawTarget = dsp;
			bmd = new BitmapData(dsp.width/block,dsp.height/block,true);
			_bitMap = new Bitmap(bmd);
			matrix = new Matrix();
			matrix.scale(1/block,1/block);
			bmd.draw(dsp,matrix);
			//trace(bmd.width,bmd.height)
			//_bitMap.addChild(bmd);
			_bitMap.width = dsp.width;
			_bitMap.height = dsp.height;
			if(isActive){
				//this.addEventListener(Event.ADDED_TO_STAGE,onEnter);
				_bitMap.addEventListener(Event.ENTER_FRAME,onEnter);
			}
		}
		private function onEnter(e:Event):void
		{
			bmd.draw(drawTarget,matrix);
		}
		public function get bitMap():Bitmap{
			return _bitMap;
		}
		public function set active(b:Boolean):void
		{
			if(b){
				if(!isActive){
					_bitMap.addEventListener(Event.ENTER_FRAME,onEnter);
					isActive = true;
				}
			}else{
				_bitMap.removeEventListener(Event.ENTER_FRAME,onEnter);
				isActive = false;
			}
		}
		public function get bitmapData():BitmapData{
			return bmd;
		}
	}
	
}