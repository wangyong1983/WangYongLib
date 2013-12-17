package org.wang.website.template 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.XMLLoaderVars;
	import com.greensock.loading.XMLLoader;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.ISiteFactory;
	import org.wang.interfaces.ISitePage;
	import org.wang.website.AlertManager;
	import org.wang.website.event.PageEvent;
	import org.wang.website.factory.BaseSiteFactory;
	import org.wang.website.PopManager;
	import org.wang.website.SiteGlobal;
	import org.wang.website.view.BasePage;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class MainTemplate extends Sprite 
	{
		public static const ON_LOADING:String = "sitestate_loading";
		public static const ON_READY:String = "sitestate_pageready";
		public static const ON_NROMAL:String = "sitestate_normal";
		public static const ON_QUITING:String = "sitestate_quiting";
		private var readyPage:ISitePage;
		protected var readyObject:Object;
		protected var currPage:ISitePage;
		protected var currPageId:int;
		protected var siteGlobal:SiteGlobal;
		protected var factory:ISiteFactory;
		protected var factoryConfigURL:String;
		protected var configLoader:XMLLoader;
		protected var siteState:String;
		protected var _pageReadySignal:Signal;
		public function MainTemplate() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		protected function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			siteGlobal = SiteGlobal.getInstance();
			SiteGlobal.getInstance().resizeManager.stage = stage;
			PopManager.init();
			PopManager.container = siteGlobal.root.popContainer;
			AlertManager.init();
			AlertManager.container = siteGlobal.root.alertContainer;
			siteGlobal.siteMenu.mainSignal.add(onMainMenuChange);
			addChildAt(siteGlobal.root, 0);
			_pageReadySignal = new Signal();
			//siteGlobal.siteMenu.subSignal.add(onSubMenuChange);
			//initSignal.dispatch();
		}
		
		protected function onMainMenuChange(n:int,obj:Object = null):void 
		{
			if (siteGlobal.siteMenu.lastMain != -1)
			{
				//以后都需先卸载上一个
				readyObject = obj;
				currPageId = n;
				switch(siteState)
				{
					case ON_LOADING:
						onNeedNextPage(currPageId);
						break;
					case ON_NROMAL:
						siteState = ON_QUITING;
						currPage.readyToRemove(obj);
						break;
				}
			}else
			{
				//第一次
				currPageId = n;
				currPage = factory.needPage(n);
				if (currPage)
				{
					siteState = ON_READY;
					currPage.pageSignal.add(onPageEvent);
					currPage.readyToAdd(obj);
				}else
				{
					siteState = ON_LOADING;
					factory.needPageSignal.addOnce(onPageLoaded);
					readyObject = obj;
					
				}
				
				
			}
			
		}
		protected function onNeedNextPage(n:int):void
		{
			currPage = factory.needPage(n);
			if (currPage)
			{
				siteState = ON_READY;
				currPage.pageSignal.add(onPageEvent);
				currPage.readyToAdd(readyObject);
				_pageReadySignal.dispatch();
			}else
			{
				siteState = ON_LOADING;
				factory.needPageSignal.add(onPageLoaded);
			}
		}
		private function onPageLoaded(page:ISitePage):void 
		{
			siteState = ON_READY;
			currPage = factory.getSitePage(currPageId);
			currPage.pageSignal.add(onPageEvent);
			currPage.readyToAdd(readyObject);
		}
		
		protected function onPageEvent(e:PageEvent):void 
		{
			//trace(e.currentTarget);
			switch(e.type)
			{
				case PageEvent.PAGE_JOIN_READY:
					currPage = e.currentTarget as ISitePage;
					siteGlobal.root.contentContainer.addChild(currPage.view as DisplayObjectContainer);
					siteState = ON_NROMAL;
					break;
				case PageEvent.PAGE_OUT_READY:
					siteGlobal.root.contentContainer.removeChild(e.currentTarget.view as DisplayObjectContainer);
					onNeedNextPage(currPageId);
					break;
			}
			//trace(siteState);
		}
		protected function onSubMenuChange(n:int,obj:Object = null):void 
		{
			
		}
	}

}