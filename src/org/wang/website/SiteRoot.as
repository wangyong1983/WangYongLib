package org.wang.website 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SiteRoot extends Sprite 
	{
		private var _alertContainer:Sprite;
		private var _menuContainer:Sprite;
		private var _loadingContainer:Sprite;
		private var _contentContainer:Sprite;
		private var _bgContainer:Sprite;
		private var _initSignal:Signal;
		private var _popContainer:Sprite;
		public function SiteRoot() 
		{
			_initSignal = new Signal();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			_menuContainer = new Sprite();
			_loadingContainer = new Sprite();
			_contentContainer = new Sprite();
			_bgContainer = new Sprite();
			_alertContainer = new Sprite();
			_popContainer = new Sprite();
			addChild(_bgContainer);
			addChild(_contentContainer);
			addChild(_menuContainer);
			addChild(_popContainer);
			addChild(_loadingContainer);
			
			addChild(_alertContainer);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_initSignal.dispatch();
		}
		public function get menuContainer():Sprite 
		{
			return _menuContainer;
		}
		
		public function get loadingContainer():Sprite 
		{
			return _loadingContainer;
		}
		
		public function get contentContainer():Sprite 
		{
			return _contentContainer;
		}
		
		public function get bgContainer():Sprite 
		{
			return _bgContainer;
		}
		
		public function get initSignal():Signal 
		{
			return _initSignal;
		}
		
		public function get alertContainer():Sprite 
		{
			return _alertContainer;
		}
		
		public function get popContainer():Sprite 
		{
			return _popContainer;
		}
	}

}