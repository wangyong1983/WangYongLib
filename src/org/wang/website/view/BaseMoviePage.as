package org.wang.website.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.Security;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.ISitePage;
	import org.wang.website.event.PageEvent;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseMoviePage extends MovieClip implements ISitePage 
	{
		private var _pageSignal:Signal;
		public function BaseMoviePage() 
		{
			super();
			Security.allowDomain("*");
			_pageSignal = new Signal(PageEvent);
			view.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			view.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		/*离开场景后如还需出场动画则复盖此方法并在动画结束时再调用PageEvent.PAGE_OUT_DONE事件*/
		protected function onRemoved(e:Event):void 
		{
			dispatchEventByName(PageEvent.PAGE_OUT_DONE);
		}
		/*加入场景后如还需进场动画则复盖此方法并在动画结束时再调用PageEvent.PAGE_JOIN_DONE事件*/
		protected function onAdded(e:Event):void 
		{
			dispatchEventByName(PageEvent.PAGE_JOIN_DONE);
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
		public function readyToAdd(o:Object = null):void 
		{
			dispatchEventByName(PageEvent.PAGE_JOIN_READY);
		}
		
		public function readyToRemove(o:Object = null):void 
		{
			dispatchEventByName(PageEvent.PAGE_OUT_READY);
		}
		
		public function get view():DisplayObjectContainer 
		{
			return this;
		}
	}

}