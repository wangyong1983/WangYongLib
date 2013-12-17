package org.wang.website.factory
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.LoaderStatus;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.greensock.loading.data.XMLLoaderVars;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IAlert;
	import org.wang.interfaces.IInventory;
	import org.wang.interfaces.IPopwindow;
	import org.wang.interfaces.ISiteFactory;
	import org.wang.interfaces.ISitePage;
	import org.wang.interfaces.IView;
	import org.wang.view.BaseView;
	import org.wang.website.view.BasePage;

	public class BaseSiteFactory implements ISiteFactory
	{
		private var mapping:Vector.<ISitePage>;
		private static var _instance:BaseSiteFactory;
		private var swfLoaders:Vector.<SWFLoader>;
		private var musicLoaders:Vector.<MP3Loader>;
		private var imageLoaders:Vector.<ImageLoader>;
		private var _onLoadSignal:Signal;
		private var configLoader:XMLLoader;
		private var _needPageSignal:Signal;
		private var _pageClasses:Vector.<Class>;
		private var lastNeed:int;
		private var _onLoadStartSignal:Signal;
		private var _onLoadProgressSignal:Signal;
		private var _absoluteURL:Boolean;
		private var alertList:Dictionary;
		public static function getInstance():BaseSiteFactory
		{
			if (_instance == null)
			{
				_instance = new BaseSiteFactory();
			}
			return _instance;
		}
		public function BaseSiteFactory()
		{
			
			_needPageSignal = new Signal(ISitePage);
			
			_onLoadStartSignal = new Signal(LoaderEvent);
			_onLoadProgressSignal = new Signal(LoaderEvent);
			_onLoadSignal = new Signal(LoaderEvent);
			
			popList = new Dictionary();
			alertList = new Dictionary();
			viewList = new Dictionary();
		}
		/**
		 * 
		 * @param	需要第n个页面 如果有则返回,如果没有则触发Loading
		 * @return 返回所需的页面
		 */
		public function needPage(n:int):ISitePage
		{
			//return _needPageSignal;
			lastNeed = n;
			if (mapping[n])
			{
				return mapping[n];
			}else
			{
				return checkPage(n);
			}
		}
		public function getDomain():String
		{
			return xmlData.siteUrls.@domain;
		}
		public function getURL(s:String,b:Boolean = false):String
		{
			var str:String = "";
			var url:String = xmlData.siteUrls.url.(@name == s).toString();
			if(b)
			{
				return url;
			}
			
			if (_absoluteURL)
			{
				str += getDomain();
			}
			
			if (url.search("://") == -1)
			{
				return str + url;
			}else
			{
				return url;
			}
			
		}
		protected function checkPage(n:int):ISitePage 
		{
			lastNeed = n;
			
			var loader:SWFLoader = SWFLoader(LoaderMax.getLoader(xmlData.siteTree.channels.channel.(@id == n).@loader));
			if (loader.status == LoaderStatus.COMPLETED)
			{
				var skinName:String = xmlData.siteTree.channels.channel.(@id == n).@skinName;
				if (skinName)
				{
					var cls:Class = loader.getClass(skinName);
					if (cls)
					{
						mapping[n] = new _pageClasses[n](new cls() as DisplayObjectContainer);
						return mapping[n];
					}else
					{
						return null;
					}
				}else
				{
					if (loader.rawContent is ISitePage)
					{
						mapping[n] = loader.rawContent as ISitePage;
						return mapping[n];
					}else
					{
						trace("SWF没有实现 ISitePage接口");
						return null;
					}
					
				}
			}else
			{
				loader.addEventListener(LoaderEvent.OPEN, onLoadChildLoad);
				loader.addEventListener(LoaderEvent.PROGRESS, onLoadChildLoad);
				loader.addEventListener(LoaderEvent.COMPLETE, onLoadChildLoad);
				loader.addEventListener(LoaderEvent.COMPLETE, onPageSWFLoaded);
				loader.load();
				trace("开始加载 "+loader.url);
				return null;
			}
			
		}
		private function onLoadChildLoad(e:LoaderEvent):void
		{
			switch(e.type)
			{
				case LoaderEvent.OPEN:
					trace("loadOpen.....");
					_onLoadStartSignal.dispatch(e);
					break;
				case LoaderEvent.PROGRESS:
					_onLoadProgressSignal.dispatch(e);
					break;
				case LoaderEvent.COMPLETE:
					trace("complete.....");
					_onLoadSignal.dispatch(e);
					break;
			}
			
		}
		private function onPageSWFLoaded(e:LoaderEvent):void 
		{
			//trace("loaded");
			var page:ISitePage = checkPage(lastNeed);
			if (page)
			{
				_needPageSignal.dispatch(page);	
			}
		}
		/**
		 * 
		 * @param	className 类名
		 * @param	loaderName Loader名 默认为 mainCompnents
		 * @return
		 */
		public function getClassInSWF(className:String,loaderName:String):Class
		{
			var loader:SWFLoader = LoaderMax.getLoader(loaderName);
			if(loader)
			{
				return loader.getClass(className) as Class;
			}else
			{
				trace("没有找到Loader: "+loaderName);
				return null;
			}
			
		}
		/**
		 * 
		 * @param	加载配置文件
		 */
		public function loadFactoryConfig(url:String):void
		{
			var configVars:XMLLoaderVars = new XMLLoaderVars();
			configVars.noCache(false);
			configVars.onOpen(_onLoadStartSignal.dispatch);
			configVars.onProgress(_onLoadProgressSignal.dispatch);
			configVars.onComplete(onLoadComplete);
			configLoader = new XMLLoader(url, configVars);
			configLoader.load();
		}
		
		private function onLoadComplete(e:LoaderEvent):void 
		{
			mapping = new Vector.<ISitePage>(xmlData.siteTree.channels.channel.length(),true);
			_pageClasses = new Vector.<Class>(xmlData.siteTree.channels.channel.length(), true);
			_onLoadSignal.dispatch(e);
		}
		
		private function onLoadStart(e:LoaderEvent):void 
		{
			_onLoadStartSignal.dispatch(e);
		}
		public function set stage(s:Stage):void
		{
			_stage = s;
			//_stage.root.loaderInfo.loaderURL
		}
		public function get stage():Stage
		{
			return _stage;
		}
		/**
		 * 
		 * @param	获得页面
		 * @return
		 */
		public function getSitePage(n:int):ISitePage
		{
			return mapping[n];
		}
		private var popList:Dictionary;
		public function getPopWindow(inventory:IInventory, obj:* = null, isNew:Boolean = false):IPopwindow
		{
			//inventory.className
			if (popList[inventory.name])
			{
				IPopwindow(popList[inventory.name]).vars = obj;
				return popList[inventory.name] as IPopwindow;
			}
			var cls:Class = inventory.className;
			var skin:Class = getClassInSWF(inventory.skinName, inventory.loaderName);
			var iPopWindow:IPopwindow = new cls(new skin() as DisplayObjectContainer) as IPopwindow;
			popList[inventory.name] = iPopWindow;
			if(obj)
				iPopWindow.vars = obj;
			return iPopWindow;
		}
		private var viewList:Dictionary;
		private var _stage:Stage;
		public function getView(inventory:IInventory,isNew:Boolean = false):IView
		{
			if (viewList[inventory.name] && !isNew)
			{
				return viewList[inventory.name] as IView;
			}
			var cls:Class = inventory.className;
			var skin:Class = getClassInSWF(inventory.skinName, inventory.loaderName);
			var iView:IView = new cls(new skin() as DisplayObjectContainer) as IView;
			viewList[inventory.name] = iView;
			return iView;
		}
		public function getAlertWindow(inventory:IInventory, obj:* = null, isNew:Boolean = false):IAlert
		{
			//alertList
			if (alertList[inventory.name] && !isNew)
			{
				IAlert(popList[inventory.name]).vars = obj;
				return popList[inventory.name] as IAlert;
			}
			var cls:Class = inventory.className;
			var skin:Class = getClassInSWF(inventory.skinName, inventory.loaderName);
			var iPopWindow:IAlert = new cls(new skin() as DisplayObjectContainer) as IAlert;
			popList[inventory.name] = iPopWindow;
			if(obj)
				iPopWindow.vars = obj;
			return iPopWindow;
		}
		
		
//		private static function getRootPath( str:String ):String{
//			var debugN:int = str.lastIndexOf( '\\' );
//			if( debugN == -1 ){
//				var subN:int = str.lastIndexOf( '/' );
//				str = str.substring( 0, subN );
//			}else{
//				str = str.substring( 0, debugN );
//			}
//			return str;
//		}
////		getDomain()
//		public static function fixPath( file:String ):*{
//			trace("domain:" + getInstance().getDomain())
//			var res:Array = file.split('../');
//			var root:String = getInstance().getDomain();
//			if( res && res.length>0 ){
//				var ps:Array = root.split('/');
//				for( var i:int=0; i<res.length; i++ ){
//					ps.pop();
//				}
//				root = ps.join( '/' ) + '/';
//				while( file.indexOf('../') != -1 ){
//					file = file.replace( '../', '' );
//				}
//			}
//			return root + file;
//		}
		
		/**
		 * 返回Config数据
		 */
		public function get xmlData():XML 
		{
			return configLoader.content as XML;
		}
		
		public function get needPageSignal():Signal 
		{
			return _needPageSignal;
		}
		
		public function get pageClasses():Vector.<Class> 
		{
			return _pageClasses;
		}
		
		public function get onLoadStartSignal():Signal 
		{
			return _onLoadStartSignal;
		}
		
		public function get onLoadProgressSignal():Signal 
		{
			return _onLoadProgressSignal;
		}
		
		public function get onLoadCompleteSignal():Signal 
		{
			return _onLoadSignal;
		}
		
		public function get absoluteURL():Boolean 
		{
			return _absoluteURL;
		}
		
		public function set absoluteURL(value:Boolean):void 
		{
			_absoluteURL = value;
		}
	}
}