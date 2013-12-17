package org.wang.website.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	import org.wang.events.EasyButtonEvent;
	import org.wang.interfaces.IPopwindow;
	import org.wang.utils.EasyButton;
	import org.wang.view.BaseView;
	import org.wang.website.AlignManager;
	import org.wang.website.ResizeManager;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BasePopWindow extends BaseView implements IPopwindow 
	{
		protected var _closeSignal:Signal;
		private var _shieldLayer:Sprite;
		private var _shield:Boolean;
		private var _autoSize:Boolean;
		protected var _closeButton:EasyButton;
		private var _autoAlign:Boolean;
		private var _alignManager:AlignManager;
		protected var _alignRect:Rectangle;
		protected var _vars:*;
		public function BasePopWindow(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		
		private function init():void 
		{
			_shield = true;
			_autoSize = true;
			_closeSignal = new Signal(IPopwindow);
			_closeButton = new EasyButton(getChildMovieByName("_close"));
			_closeButton.addEventListener(EasyButtonEvent.CLICK, onClose);
			_alignRect = view.getRect(view);
			autoAlign = true;
		}
		
		protected function onClose(e:EasyButtonEvent):void 
		{
			closeSignal.dispatch(this);
		}
		
		public function get closeSignal():Signal 
		{
			return _closeSignal;
		}
		
		public function get shieldLayer():Sprite 
		{
			return _shieldLayer;
		}
		
		public function get autoSize():Boolean 
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
		}
		
		public function get autoAlign():Boolean 
		{
			return _autoAlign;
		}
		
		public function set autoAlign(value:Boolean):void 
		{
			_autoAlign = value;
			if (_autoAlign)
			{
				_alignManager = AlignManager.add(view, "MM", new Point(-_alignRect.width / 2, -_alignRect.height / 2));
			}else
			{
				AlignManager.remove(view);
				_alignManager = null;
			}
			
		}
		
		public function get alignManager():AlignManager 
		{
			return _alignManager;
		}
		
		public function get alignRect():Rectangle 
		{
			return _alignRect;
		}
		public function set alignRect(rect:Rectangle):void
		{
			_alignRect = rect;
			if (_autoAlign)
			{
				autoAlign = true;
			}
		}
		
		public function get shield():Boolean 
		{
			return _shield;
		}
		
		public function set shield(value:Boolean):void 
		{
			_shield = value;
		}

		public function get vars():*
		{
			return _vars;
		}

		public function set vars(value:*):void
		{
			_vars = value;
		}

	}

}