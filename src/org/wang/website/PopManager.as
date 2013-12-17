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
	public class PopManager 
	{
		static protected var _container:DisplayObjectContainer;
		static protected var popDictionary:Dictionary = new Dictionary();
		static protected var _shieldLayer:Sprite;
		static protected var _popNum:int = 0;
		static protected var _alpha:Number;
		static protected var _color:uint;
		public function PopManager() 
		{
			_alpha = 0.5;
			_color = 0x000000;
		}
		public static function init():void
		{
			_shieldLayer = new Sprite();
			_shieldLayer.graphics.beginFill(0x000000, 1);
			_shieldLayer.graphics.drawRect(0,0,ResizeManager.getInstance().stageWidth, ResizeManager.getInstance().stageHeight);
			_shieldLayer.graphics.endFill();
			ResizeManager.getInstance().resizeSignal.add(onResize);
		}
		static private function fresh():void
		{
			_shieldLayer.graphics.clear();
			_shieldLayer.graphics.beginFill(_color, _alpha);
			_shieldLayer.graphics.drawRect(0,0,ResizeManager.getInstance().stageWidth, ResizeManager.getInstance().stageHeight);
			_shieldLayer.graphics.endFill();
		}
		static private function onResize(w:Number,h:Number):void 
		{
			_shieldLayer.width = w;
			_shieldLayer.height = h;
		}
		public static function pop(p:IPopwindow,args:* = null):IPopwindow
		{
			if (_container)
			{
				if (args)
				{
					p.vars = args;
				}
				p.closeSignal.addOnce(onClose);
				_container.addChild(_shieldLayer);
				_container.addChild(p.view);
				_popNum++;
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
		
		static public function get popNum():int 
		{
			return _popNum;
		}
		
		static public function get alpha():Number 
		{
			return _alpha;
		}
		
		static public function set alpha(value:Number):void 
		{
			_alpha = value;
			fresh();
		}
		
		static public function get color():Number 
		{
			return _color;
		}
		
		static public function set color(value:Number):void 
		{
			_color = value;
			fresh();
		}
	}

}