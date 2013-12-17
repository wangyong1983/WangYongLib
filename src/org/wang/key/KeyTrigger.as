package org.wang.key 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class KeyTrigger extends EventDispatcher
	{
		private var key:Number;
		private var stage:Stage;
		private var isOpen:Boolean = false;
		private var downTriggerDictionary:Dictionary;
		private var upTriggerDictionary:Dictionary;
		public function KeyTrigger(stage:Stage) 
		{
			this.stage = stage;
			downTriggerDictionary = new Dictionary(true);
			upTriggerDictionary = new Dictionary(true);
		}
		public function open():void
		{
			if (!isOpen) {
				isOpen = true;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown,false,0,true);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
			}
			
		}
		public function close():void
		{
			if (isOpen) {
				isOpen = false;
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
			
		}
		private function onKeyUp(e:KeyboardEvent):void 
		{
			var code:uint = e.keyCode;
			if (upTriggerDictionary[code] != null) {
				upTriggerDictionary[code](e);
			}
		}
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var code:uint = e.keyCode;
			if (downTriggerDictionary[code] != null) {
				downTriggerDictionary[code](e);
			}
		}
		public function addDownTrigger(n:uint,func:Function):void
		{
			downTriggerDictionary[n] = func;
		}
		public function addUpTrigger(n:uint, func:Function):void
		{
			upTriggerDictionary[n] = func;
		}
	}

}