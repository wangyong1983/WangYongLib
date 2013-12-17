package org.wang.website.common 
{
	import flash.events.EventDispatcher;
	import org.osflash.signals.Signal;
	import org.wang.website.event.SiteResultErrorEvent;
	import org.wang.website.event.SystemErrorEvent;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SiteEventCenter
	{
		private var _errorSignal:Signal;
		static private var _instance:SiteEventCenter;
		private var _resultErrorSignal:Signal;
		private var _popSignal:Signal;
		private var _eventDispatcher:EventDispatcher;
		public static function getInstance():SiteEventCenter
		{
			if (_instance == null)
			{
				_instance = new SiteEventCenter();
			}
			return _instance;
		}
		public function SiteEventCenter() 
		{
			_errorSignal = new Signal(SystemErrorEvent);
			_resultErrorSignal = new Signal(SiteResultErrorEvent);
			_popSignal = new Signal(String);
			_eventDispatcher = new EventDispatcher();
		}
		
		public function get errorSignal():Signal 
		{
			return _errorSignal;
		}
		public function get resultErrorSignal():Signal 
		{
			return _resultErrorSignal;
		}
		
		public function get popSignal():Signal 
		{
			return _popSignal;
		}
		
		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}
		
	}

}