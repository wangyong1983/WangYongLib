package org.wang.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class LocalFileLoader 
	{
		private var fileReference:FileReference;
		private var _loadedSignal:Signal;
		private var _imageLoadedSignal:Signal;
		private var loader:Loader;
		private var fileFilter:FileFilter;
		public function LocalFileLoader() 
		{
			_loadedSignal = new Signal(DisplayObject);
			_imageLoadedSignal = new Signal(Bitmap);
			fileReference = new FileReference();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			fileReference.addEventListener(Event.SELECT, onSelected);
			fileReference.addEventListener(Event.COMPLETE, onFileLoaded);
			fileFilter = new FileFilter("Images *.jpg;*.png", "*.jpg;*.png");
		}
		
		private function onLoaded(e:Event):void 
		{
			_loadedSignal.dispatch(loader.content);
			var tempData:BitmapData = new BitmapData(loader.width, loader.height, false);
			tempData.draw(loader);
			var bitmap:Bitmap = new Bitmap(tempData, "auto", true);
			_imageLoadedSignal.dispatch(bitmap);
		}
		
		private function onFileLoaded(e:Event):void 
		{
			loader.loadBytes(fileReference.data);
		}
		
		private function onSelected(e:Event):void 
		{
			fileReference.load();
		}
		
		public function get loadedSignal():Signal 
		{
			return _loadedSignal;
		}
		
		public function get imageLoadedSignal():Signal 
		{
			return _imageLoadedSignal;
		}
		public function browse(arr:Array = null):void
		{
			fileReference.browse(arr);
		}
		public function broseImage(arr:Array = null):void
		{
			if (arr == null)
			{
				//trace("BrowsImage");
				fileReference.browse([fileFilter]);
			}else
			{
				fileReference.browse(arr);
			}
			
		}
	}

}