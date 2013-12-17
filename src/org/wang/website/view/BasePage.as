package org.wang.website.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.ISitePage;
	import org.wang.view.BaseView;
	import org.wang.website.AlignManager;
	import org.wang.website.event.PageEvent;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BasePage extends BaseView implements ISitePage 
	{
		protected var _pageSignal:Signal;
		public function BasePage(v:DisplayObjectContainer) 
		{
			super(v);
			_pageSignal = new Signal(PageEvent);
			view.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			view.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			initPage();
		}
		
		/*把动画加载到场景之前的准备阶段调用此方法,如在入场之前需要做准备则复盖此方法并在准备完成时调用PageEvent.PAGE_JOIN_READY事件*/
		public function readyToAdd(arg:Object = null):void
		{
			dispatchEventByName(PageEvent.PAGE_JOIN_READY);
		}
		/*把动画从场景删除之前的准备阶段调用此方法,如在出场之前需要做准备则复盖此方法并在准备完成时调用PageEvent.PAGE_OUT_READY事件*/
		public function readyToRemove(arg:Object = null):void
		{
			dispatchEventByName(PageEvent.PAGE_OUT_READY);
		}
		/*离开场景后如还需出场动画则复盖此方法并在动画结束时再调用PageEvent.PAGE_OUT_DONE事件*/
		protected function onRemoved(e:Event):void 
		{
			//removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			dispatchEventByName(PageEvent.PAGE_OUT_DONE);
		}
		/*加入场景后如还需进场动画则复盖此方法并在动画结束时再调用PageEvent.PAGE_JOIN_DONE事件*/
		protected function onAdded(e:Event):void 
		{
			//removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			dispatchEventByName(PageEvent.PAGE_JOIN_DONE);
		}
		
		protected function initPage():void 
		{
			//在此初始化View里的素
			dispatchEventByName(PageEvent.PAGE_INIT);
		}
		public function get pageSignal():ISignal
		{
			return _pageSignal;
		}
		private function dispatchEventByName(s:String):void
		{
			var event:PageEvent = new PageEvent(s);
			event.currentTarget = this;
			event.target = view;
			event.signal = pageSignal;
			event.bubbles = true;
			_pageSignal.dispatch(event);
			
		}
	}

}