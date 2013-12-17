package org.wang.common 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.wang.interfaces.IToolTipSkin;
	import org.wang.view.BaseToolTipSkin;
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class EasyToolTip 
	{
		private static var _defaultContainer:DisplayObjectContainer;
		private static var _defaultSkin:IToolTipSkin;
		private static var _defaultSkinMovie:DisplayObjectContainer;
		private var _container:DisplayObjectContainer;
		private var _target:DisplayObjectContainer;
		private var _tipSkin:IToolTipSkin;
		private var _tipSkinMovie:DisplayObjectContainer;
		private var _follow:Boolean;
		private var _location:Point;
		private var _regularLocation:Point;
		private var _message:String;
		

		public static function set defaultSkin(skin:IToolTipSkin):void
		{
			_defaultSkin = skin;
			_defaultSkinMovie = skin.view;
			
		}
		public function EasyToolTip(target:DisplayObjectContainer, message:String = null,skin:IToolTipSkin = null,container:DisplayObjectContainer = null)
		{
			_follow = true;
			_location = new Point();
			_regularLocation = new Point();
			
			_target = target;
			
			if (container) {
				_container = container;
			}else if(_defaultContainer){
				_container = _defaultContainer;
			}else {
				_container = target.parent;
			}
			
			if (skin) {
				_tipSkin = skin;
				_tipSkinMovie = skin.view;
			}else if (_defaultSkin) {
				_tipSkin = _defaultSkin;
				_tipSkinMovie = _defaultSkinMovie;
			}else {
				_tipSkin = new BaseToolTipSkin();
				_tipSkinMovie = _tipSkin.view;
			}
			
			_message = message;
			_tipSkin.tipText = message;
			target.addEventListener(MouseEvent.MOUSE_OVER, onMouseHandle);
		}
		protected function show():void
		{
			_container.addChild(_tipSkinMovie);
			target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseHandle);
			target.addEventListener(MouseEvent.MOUSE_OUT, onMouseHandle);
			
			if (_follow) {
				move();
			}else {
				_tipSkinMovie.x = _target.x + _regularLocation.x;
				_tipSkinMovie.y = _target.y + _regularLocation.y;
			}
			
		}
		protected function move():void
		{
			if(_follow){
				_tipSkinMovie.x = _target.x + _target.mouseX + location.x;
				_tipSkinMovie.y = _target.y + _target.mouseY + location.y;
			}
		}
		protected function hide():void
		{
			target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseHandle);
			target.removeEventListener(MouseEvent.MOUSE_OUT, onMouseHandle);
			_container.removeChild(_tipSkinMovie);
		}
		public function unregister():void
		{
			target.removeEventListener(MouseEvent.MOUSE_OVER, onMouseHandle);
			target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseHandle);
			target.removeEventListener(MouseEvent.MOUSE_OUT, onMouseHandle);
		}
		public static function register(target:DisplayObjectContainer, message:String = null, skin:IToolTipSkin = null,container:DisplayObjectContainer = null):EasyToolTip
		{
			return new EasyToolTip(target,message,skin,container);
		}
		public static function unregister(tip:EasyToolTip):void
		{
			tip.unregister();
		}
		private function onMouseHandle(e:MouseEvent):void 
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
				show();
				break;
				case MouseEvent.MOUSE_OUT:
				hide();
				break;
				case MouseEvent.MOUSE_MOVE:
				move();
				break;
			}
		}
		
		public static function set defaultContainer(container:DisplayObjectContainer):void
		{
			_defaultContainer = container;
		}
		public static function get defaultContainer():DisplayObjectContainer
		{
			return _defaultContainer;
		}
		
		public function get follow():Boolean 
		{
			return _follow;
		}
		
		public function set follow(value:Boolean):void 
		{
			_follow = value;
		}
		
		public function get location():Point 
		{
			return _location;
		}
		
		public function set location(value:Point):void 
		{
			_location = value;
		}
		
		public function get regularLocation():Point 
		{
			return _regularLocation;
		}
		
		public function set regularLocation(value:Point):void 
		{
			_regularLocation = value;
		}
		
		public function get target():DisplayObjectContainer 
		{
			return _target;
		}
		
		public function set target(value:DisplayObjectContainer):void 
		{
			_target = value;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
		public function set message(value:String):void 
		{
			_tipSkin.tipText = value;
			_message = value;
		}
		
	}

}
