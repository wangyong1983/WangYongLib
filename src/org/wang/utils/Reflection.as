package org.wang.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.display.SpreadMethod
	import flash.display.BlendMode
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class Reflection extends Sprite 
	{
		private var _img:Bitmap;
		private var _distance:Number;
		private var _offset:Number;
		private var _reflectionImgData:BitmapData
		private var _reflectionImg:Bitmap;

		private var _reflectionContainer:Sprite;
		private var _reflectionLight:Sprite;
		/**
		* 构造函数
		* @param newImg   倒影图片对象
		* @param distance 倒影与图片距离
		* @param offset   倒影偏移量
		*/
		public function Reflection(newImg:DisplayObject,distance:Number,offset:Number=100) 
		{
			var bmd:BitmapData = new BitmapData(newImg.width, newImg.height, true);
			bmd.draw(newImg);
			_img = new Bitmap(bmd);
			_distance = distance;
			_offset = offset;

			addChild(_img);
			initReflection();
		}

		private function initReflection():void
		{
			var imgData:BitmapData = _img.bitmapData;
			_reflectionImgData = imgData.clone();
			_reflectionImg = new Bitmap(_reflectionImgData);
			_reflectionContainer = new Sprite();
			_reflectionImg.scaleY *= -1;
			_reflectionImg.y = _img.y + (_img.height*2) + _distance;
			_reflectionContainer.addChild(_reflectionImg);
			_reflectionContainer.blendMode = BlendMode.LAYER;
			_reflectionLight = new Sprite();
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0x000000, 0xFFFFFF];
			var alphas:Array = [1, 0];
			var ratios:Array = [0, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_img.width,_img.height , Math.PI / 2, 0, _offset+_distance);
			var spreadMethod:String = SpreadMethod.PAD;
			_reflectionLight.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			_reflectionLight.graphics.drawRect(0, _img.y+_img.height+_distance, _img.width, _img.height);
			_reflectionLight.graphics.endFill();
			_reflectionLight.blendMode = BlendMode.ALPHA;
			_reflectionContainer.addChild(_reflectionLight);
			this.addChild(_reflectionContainer);
		}
		
	}

}