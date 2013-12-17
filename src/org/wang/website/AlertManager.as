package org.wang.website 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import org.wang.interfaces.IPopwindow;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class AlertManager
	{
		static protected var _container:DisplayObjectContainer;
		static protected var popDictionary:Dictionary = new Dictionary();
		static protected var _shieldLayer:Sprite;
		static protected var _popNum:int = 0;
		public function AlertManager() 
		{
			super();
			
		}
		public static function init():void
		{
			_shieldLayer = new Sprite();
			_shieldLayer.graphics.beginFill(0x000000, 0.5);
			_shieldLayer.graphics.drawRect(0,0,ResizeManager.getInstance().stageWidth, ResizeManager.getInstance().stageHeight);
			_shieldLayer.graphics.endFill();
			ResizeManager.getInstance().resizeSignal.add(onResize);
		}
		static private function onResize(w:Number,h:Number):void 
		{
			_shieldLayer.width = w;
			_shieldLayer.height = h;
		}
		static public  function pop(p:IPopwindow):IPopwindow
		{
			if (_container)
			{
				p.closeSignal.addOnce(onClose);
				_container.addChild(_shieldLayer);
				_container.addChild(p.view);
			}
			return p;
		}
		static protected function onClose(p:IPopwindow):void 
		{
			if (_container.contains(p.view))
			{
				_container.removeChild(p.view);
				if (_container.numChildren == 1)
				{
					_container.removeChild(_shieldLayer);
				}else
				{
					_container.addChildAt(_shieldLayer,0);
				}
			}
			
		}
		static public function get container():DisplayObjectContainer 
		{
			return _container;
		}
		
		static public function set container(value:DisplayObjectContainer):void 
		{
			_container = value;
		}
		static public function get shieldLayer():Sprite 
		{
			return _shieldLayer;
		}
	}

}