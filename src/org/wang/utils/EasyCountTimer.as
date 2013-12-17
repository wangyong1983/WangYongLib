package org.wang.utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyCountTimer 
	{
		private var _timeLimit:uint;
		private var startTime:uint;
		private var _remaining:uint;
		private var _now:uint;
		private var _running:Boolean;
		private var existTime:uint;
		private var enterFrameTarget:Sprite;
		private var _ringSignal:Signal;
		private var _timeSignal:Signal;
		public function EasyCountTimer(time:uint = 10000,auto:Boolean = true) 
		{
			_timeLimit = time;
			enterFrameTarget = new Sprite();
			_ringSignal = new Signal(EasyCountTimer);
			_timeSignal = new Signal(uint, uint, uint);
			if (auto)
			{
				start();
			}
			
		}
		public function start(time:uint = 0):void
		{
			if (time)
			{
				_timeLimit = time;
			}
			startTime = getTimer();
			existTime = 0;
			_running = true;
			enterFrameTarget.addEventListener(Event.ENTER_FRAME, onEnterCheck);
		}
		public function stop():void
		{
			existTime = now;
			_running = false;
			enterFrameTarget.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
		}
		private function onEnterCheck(e:Event):void 
		{
			
			if (!remaining)
			{
				_running = false;
				_now = _timeLimit;
				_remaining = 0;
				existTime = _timeLimit;
				enterFrameTarget.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
				_ringSignal.dispatch(this);
			}
			_timeSignal.dispatch(_now, _remaining, _timeLimit);
		}
		public function pause():void
		{
			if (_running)
			{
				existTime = now;
				_running = false;
			}
		}
		public function resume():void
		{
			if (_running)
			{
				return;
			}
			_running = true;
			startTime = getTimer();
		}
		public function get timeLimit():uint 
		{
			return _timeLimit;
		}
		
		public function set timeLimit(value:uint):void 
		{
			if (_running)
			{
				start();
			}
			_timeLimit = value;
		}
		/*现在走了多长时间*/
		public function get now():uint 
		{
			if (_running) 
			{
				_now = getTimer() - startTime + existTime;
			}else
			{
				_now = existTime;
			}
			
			return _now;
		}
		/*还剩余多少时间*/
		public function get remaining():uint 
		{
			if (_timeLimit <= now)
			{
				_remaining = 0;
			}else
			{
				_remaining = _timeLimit - now;
			}
			return _remaining;
		}
		
		public function get ringSignal():Signal 
		{
			return _ringSignal;
		}
		
		public function get timeSignal():Signal 
		{
			return _timeSignal;
		}
		
		public function get running():Boolean 
		{
			return _running;
		}

	}

}