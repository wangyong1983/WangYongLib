package org.wang.image 
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IView;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ImageFliper implements IView
	{
		private var _container:Sprite;
		protected var imageList:Array;
		protected var showList:Array;
		private var currImage:int;
		private var totalImage:int;
		private var showImage:int;
		protected var positionArr:Array;
		protected var mid:int;
		private var _flipSignal:Signal;
		public function ImageFliper() 
		{
			_container = new Sprite();
			_flipSignal = new Signal(int, int);
		}
		
		public function init(arr:Array,num:int = 9):void
		{
			showImage = num;
			currImage = 0;
			imageList = arr;
			totalImage = imageList.length;
			trace("total:",totalImage);
			positionArr = [];
			showList = [];
			initPosition(num);
			showPosition();
			_flipSignal.dispatch(0, currentImage);
		}
		public function get currentImage():int
		{
			var midID:int = (currImage + mid) % totalImage;
			return midID;
		}
		protected function initPosition(n:int):void 
		{
			showList = [];
			mid = Math.floor(n / 2);
			var image:DisplayObjectContainer;
			var xStep:int = 60;
			var alphaStep:Number = 0.2;
			var scaleStep:Number = 0.1;
			for (var i:int = 0; i < n; i++) 
			{
				image = imageList[i] as DisplayObjectContainer;
				showList.push(image);
				var obj:Object = new Object();
				obj.x = (i - mid) * xStep;
				
				if (i < mid)
				{
					obj.rotationY = -90;
					obj.alpha = 1 - (mid - i) * alphaStep;
					obj.z = 300;
					//obj.scaleX = obj.scaleY = 1 - (mid - i) * scaleStep;
					obj.x -= 200;
				}else if(i > mid)
				{
					obj.rotationY = 90;
					obj.alpha = 1 - (i - mid) * alphaStep;
					obj.z = 300;
					//obj.scaleX = obj.scaleY = 1 - (i - mid) * scaleStep;
					obj.x += 200;
				}else
				{
					obj.rotationY = 0;
					obj.alpha = 1;
					obj.z = 0;
				}
				trace(obj.x,obj.rotationY,obj.z);
				if (i == 0 || i == n - 1)
				{
					obj.alpha = 0;
				}
				//trace(obj.scaleX)
				//trace(obj.alpha)
				positionArr.push(obj);
				//_container.addChild(image);
			}
		}
		private function showPosition(n:Number = 0):void
		{
			var image:DisplayObjectContainer;
			for (var i:int = 0; i < showImage; i++) 
			{
				image = showList[i] as DisplayObjectContainer;
				_container.addChild(image);
				var liteVars:TweenLiteVars = new TweenLiteVars(positionArr[i]);
				TweenLite.to(image, n, liteVars);
			}
			sortDepth();
		}
		public function prevImage():void
		{
			var last:int = currentImage;
			currImage--;
			currImage = (currImage + totalImage) % totalImage;
			trace("preImg,",currImage);
			_flipSignal.dispatch(last, currentImage);
			
			ready(imageList[currImage], true);
			showList.unshift(imageList[currImage]);
			_container.addChild(imageList[currImage]);
			_container.removeChild(showList.pop() as DisplayObjectContainer);
			showPosition(0.5);
			
		}
		private function ready(mc:DisplayObjectContainer,b:Boolean):void
		{
			var liteVars:TweenLiteVars;
			if (b)
			{
				//放头里
				liteVars = new TweenLiteVars(positionArr[0]);
				TweenLite.to(mc, 0, liteVars);
			}else
			{
				//放后头
				liteVars = new TweenLiteVars(positionArr[showImage-1]);
				TweenLite.to(mc, 0, liteVars);
			}
		}
		public function nextImage():void
		{
			var last:int = currentImage;
			currImage++;
			currImage = (currImage + totalImage) % totalImage;
			var buttom:int = (showImage-1 + currImage) % totalImage;
			
			
			trace("nextImg,",currImage);
			_flipSignal.dispatch(last, currentImage);
			ready(imageList[buttom], false);
			showList.push(imageList[buttom]);
			_container.addChild(imageList[buttom]);
			_container.removeChild(showList.shift() as DisplayObjectContainer);
			showPosition(0.5);
			
		}
		
		private function sortDepth():void 
		{
			for (var i:int = 0; i < showImage; i++)
			{
				if (i <= mid)
				{
					view.addChild(showList[i]);
				}
				else
				{
					view.addChildAt(showList[i], 0);
				}
			}
		}
		public function get view():DisplayObjectContainer 
		{
			return _container;
		}
		public function set name(s:String):void
		{
			_container.name = s;
		}
		public function get name():String
		{
			return _container.name;
		}
		
		public function get flipSignal():Signal 
		{
			return _flipSignal;
		}
	}

}