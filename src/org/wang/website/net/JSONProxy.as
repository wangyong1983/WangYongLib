package org.wang.website.net 
{
	
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.osflash.signals.Signal;
	import org.wang.website.common.SiteEventCenter;
	import org.wang.website.event.SiteResultErrorEvent;
	import org.wang.website.event.SystemErrorEvent;
	import org.wang.website.interfaces.ISendVO;

//	import com.adobe.serialization.json.JSON;
	//import white.event.WhiteResultErrorEvent;
	//import white.interfaces.IWhiteSendVO;
	//import white.net.vo.BaseWhiteResultVO;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class JSONProxy 
	{
		protected var _url:String;
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		protected var _allowedResultError:Boolean;
		protected var _allowedSystemError:Boolean;
		protected var _loadedSignal:Signal;
		protected var _errorSignal:Signal;
		//private var method:String;
		public function JSONProxy(url:String = "") 
		{
			if (url)
			{
				this._url = url;
			}
			//method = "POST";
			urlLoader = new URLLoader();
			urlRequest = new URLRequest(this._url);
			
			urlLoader.addEventListener(Event.COMPLETE, onLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			_loadedSignal = new Signal(Object);
			_errorSignal = new Signal(Object);
			_allowedSystemError = true;
		}
		public function loadOnWindow(vo:ISendVO = null,url:String = "", window:String = "_blank"):void
		{
			if (url)
			{
				urlRequest.url = url;
			}
			if (vo)
			{
				urlRequest.data = vo.getVariables();
				for (var name:String in urlRequest.data) 
				{
					trace(name, ":", urlRequest.data[name]);
				}
			}
			navigateToURL(urlRequest, window);
		}
		public function load(vo:ISendVO = null,url:String = "",method:String="POST"):Signal
		{
			if (url)
			{
				urlRequest.url = url;
			}
			if (vo)
			{
				urlRequest.method = method;
				urlRequest.data = vo.getVariables();
				for (var name:String in urlRequest.data) 
				{
					trace(name, ":", urlRequest.data[name]);
				}
			}
			urlLoader.load(urlRequest);
			//trace("加载:" + urlRequest.url)
			return loadedSignal;
		}
		private function onError(e:Event):void 
		{
			if (_allowedSystemError)
			{
				var event:SystemErrorEvent = new SystemErrorEvent(SystemErrorEvent.ERROR);
				event.text = "通讯失败,请检查网络或者稍后再试.";
				SiteEventCenter.getInstance().errorSignal.dispatch(event);
			}
		}
		
		private function onLoaded(e:Event):void 
		{
			var obj:Object;
			trace("通讯返回"+e.target.data);
			try {
				obj = com.adobe.serialization.json.JSON.decode(e.target.data);
//				obj = new JSON(e.target.data).getValue();
			}
			catch (e:Error)
			{
				trace("JSON解析失败:" + url);
				if (_allowedSystemError)
				{
					var event:SystemErrorEvent = new SystemErrorEvent(SystemErrorEvent.ERROR);
					event.text = "JSON解析失败";
					SiteEventCenter.getInstance().errorSignal.dispatch(event);
				}
				errorSignal.dispatch("JSON解析失败");
				return;
			}
			_loadedSignal.dispatch(obj);
			//if (obj.errorcode)
			//{
				//
				//if (_allowedResultError)
				//{
					//var resultEvent:WhiteResultErrorEvent = new WhiteResultErrorEvent(SiteResultErrorEvent.ERROR);
					//resultEvent.errorCode = obj.errorcode;
					//resultEvent.descraption = obj.descraption;
					//SiteEventCenter.getInstance().resultErrorSignal.dispatch(resultEvent);
					//errorSignal.dispatch(obj);
				//}else
				//{
					//_loadedSignal.dispatch(obj);
				//}
			//}else
			//{
				//_loadedSignal.dispatch(obj);
			//}
			
		}
		
		//public function get allowedResultError():Boolean 
		//{
			//return _allowedResultError;
		//}
		
		//public function set allowedResultError(value:Boolean):void 
		//{
			//_allowedResultError = value;
		//}
		
		public function get allowedSystemError():Boolean 
		{
			return _allowedSystemError;
		}
		
		public function set allowedSystemError(value:Boolean):void 
		{
			_allowedSystemError = value;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		public function get loadedSignal():Signal 
		{
			return _loadedSignal;
		}
		
		public function get errorSignal():Signal 
		{
			return _errorSignal;
		}
		
	}

}