package org.wang.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	import org.wang.events.EasyButtonEvent;

	public class EasyButton extends EventDispatcher
	{
		private var target:MovieClip;
		private var _id:int;
		private var targetFrame:int;
		private var _isLock:Boolean = false;
		private var _buttonEnabled:Boolean;
		private var _clickSignal:Signal
		
		public function EasyButton(mc:MovieClip)
		{
			target = mc;
			target.gotoAndStop(1);
			target.buttonMode = true;
			target.mouseChildren = false;
			target.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			_clickSignal = new Signal(EasyButton);
			if(target.parent){
				onAdded();
			}
		}
		private function onBtnOver(e:Event):void
		{
			if(!_isLock){
				targetFrame = target.totalFrames;
				
			}
			dispatchEvent(new EasyButtonEvent(EasyButtonEvent.ROLL_OVER));
		}
		private function onBtnOut(e:Event):void
		{
			if(!_isLock){
				targetFrame = 1;
			}
			dispatchEvent(new EasyButtonEvent(EasyButtonEvent.ROLL_OUT));
		}
		private function onBtnClick(e:Event):void
		{
			_clickSignal.dispatch(this);
			dispatchEvent(new EasyButtonEvent(EasyButtonEvent.CLICK));
		}
		
		public function rollOver():void
		{
			targetFrame = target.totalFrames;
			
		}
		public function rollOut():void
		{
			targetFrame = 1;
			
		}
		private function onDistory(e:Event = null):void
		{
			try{
				target.removeEventListener(MouseEvent.ROLL_OVER,onBtnOver);
				target.removeEventListener(MouseEvent.ROLL_OUT,onBtnOut);
				target.removeEventListener(MouseEvent.CLICK,onBtnClick);
				target.removeEventListener(Event.ENTER_FRAME,onEnter);
				target.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
				target.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
				target.removeEventListener(Event.REMOVED,onDistory);
			}
			catch(e:Error){}
		}
		private function onAdded(e:Event = null):void
		{
			target.addEventListener(MouseEvent.ROLL_OVER,onBtnOver);
			target.addEventListener(MouseEvent.ROLL_OUT,onBtnOut);
			target.addEventListener(MouseEvent.CLICK,onBtnClick);
			target.addEventListener(Event.ENTER_FRAME,onEnter);
		}
		private function onRemoved(e:Event = null):void
		{
			if (!_isLock) {
				targetFrame = 1;
				target.gotoAndStop(1);
			}
			target.removeEventListener(MouseEvent.ROLL_OVER,onBtnOver);
			target.removeEventListener(MouseEvent.ROLL_OUT,onBtnOut);
			target.removeEventListener(MouseEvent.CLICK,onBtnClick);
			target.removeEventListener(Event.ENTER_FRAME, onEnter);
			
		}
		private function onEnter(e:Event):void
		{
			if(target.currentFrame != targetFrame){
				if(target.currentFrame > targetFrame){
					target.prevFrame();
				}else{
					target.nextFrame();
				}
			}
		}
		public function get ID():int
		{
			return _id;
		}

		public function set ID(value:int):void
		{
			_id = value;
		}

		public function get isLock():Boolean
		{
			return _isLock;
		}

		public function set isLock(value:Boolean):void
		{
			_isLock = value;
		}
		public function get targetMovie():MovieClip
		{
			return target;
		}

		public function get buttonEnabled():Boolean
		{
			return _buttonEnabled;
		}

		public function set buttonEnabled(value:Boolean):void
		{
			_buttonEnabled = value;
			target.mouseEnabled = value;
		}
		
		public function get clickSignal():Signal 
		{
			return _clickSignal;
		}


	}
}