package org.wang.website 
{
	import org.wang.interfaces.ISiteFactory;
	import org.wang.website.common.SiteEventCenter;
	
	import org.wang.website.user.BaseUser;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class SiteGlobal 
	{
		private static var _instance:SiteGlobal;
		private var _root:SiteRoot;
		private var _resizeManager:ResizeManager;
		private var _siteMenu:SiteMenu;
		private var _eventCenter:SiteEventCenter;
		private var _vars:Object;
		private var _factory:ISiteFactory;
		public function SiteGlobal() 
		{
			_resizeManager = ResizeManager.getInstance();
			_siteMenu = new SiteMenu();
			_eventCenter = SiteEventCenter.getInstance();
			_root = new SiteRoot();
			_vars = new Object();
		}
		
		static public function getInstance():SiteGlobal 
		{
			if (_instance == null)
			{
				_instance = new SiteGlobal();
			}
			return _instance;
		}
		
		public function get root():SiteRoot 
		{
			return _root;
		}
		
		public function set root(value:SiteRoot):void 
		{
			_root = value;
		}
		
		public function get resizeManager():ResizeManager 
		{
			return _resizeManager;
		}
		
		public function get siteMenu():SiteMenu 
		{
			return _siteMenu;
		}
		
		public function get eventCenter():SiteEventCenter 
		{
			return _eventCenter;
		}
		
		public function get vars():Object 
		{
			return _vars;
		}
		
		public function set vars(value:Object):void 
		{
			_vars = value;
		}
		
		public function get factory():ISiteFactory 
		{
			return _factory;
		}
		
		public function set factory(value:ISiteFactory):void 
		{
			_factory = value;
		}
		
	}
	
}
