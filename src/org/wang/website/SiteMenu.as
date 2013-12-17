package org.wang.website 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SiteMenu 
	{
		private var _mainMenu:int;
		private var _subMenu:int;
		private var _otherMenu:Object;
		private var _mainSignal:Signal;
		private var _subSignal:Signal;
		private var _otherSignal:Signal;
		private var _lastMain:int;
		private var _lastSub:int;
		private var _lastOther:Object;
		public function SiteMenu() 
		{
			_mainMenu = -1;
			_subMenu = -1;
			_lastMain = -1;
			_lastSub = -1;
			_lastOther = null;
			_mainSignal = new Signal(int,Object);
			_subSignal = new Signal(int,Object);
			_otherSignal = new Signal(Object);
		}
		
		public function get mainMenu():int 
		{
			return _mainMenu;
		}
		public function setMainMenu(n:int, o:Object = null):void
		{
			if (_mainMenu != n)
			{
				_lastMain = _mainMenu;
				_mainMenu = n;
				_mainSignal.dispatch(_mainMenu,o);
			}
		}
		public function set mainMenu(value:int):void 
		{
			if (_mainMenu != value)
			{
				_lastMain = _mainMenu;
				_mainMenu = value;
				_mainSignal.dispatch(_mainMenu,null);
			}
			
		}
		public function setSubMenu(n:int, o:Object = null):void
		{
			if (_subMenu != n)
			{
				_lastSub = _subMenu;
				_subMenu = n;
				_subSignal.dispatch(_subMenu,o);
			}
		}
		public function get subMenu():int 
		{
			return _subMenu;
		}
		
		public function set subMenu(value:int):void 
		{
			if (_subMenu != value)
			{
				_lastSub = _subMenu;
				_subMenu = value;
				_subSignal.dispatch(_subMenu,null);
			}
			
		}
		
		public function get otherMenu():Object 
		{
			return _otherMenu;
		}
		
		public function set otherMenu(value:Object):void 
		{
			if (_otherMenu != value)
			{
				_lastOther = _otherMenu;
				_otherMenu = value;
				_otherSignal.dispatch(value);
			}
			
		}
		
		public function get mainSignal():Signal 
		{
			return _mainSignal;
		}
		
		public function get subSignal():Signal 
		{
			return _subSignal;
		}
		
		public function get lastMain():int 
		{
			return _lastMain;
		}
		
		public function get lastSub():int 
		{
			return _lastSub;
		}
		
		public function get lastOther():Object 
		{
			return _lastOther;
		}
		
	}

}