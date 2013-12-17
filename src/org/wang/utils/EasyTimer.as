package org.wang.utils
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.osflash.signals.Signal;

	public class EasyTimer
	{
		private var _timeLimit:uint;
		private var _ringSignal:Signal;
		private var _timeSignal:Signal;
		private var startTime:uint;
		private var _remaining:uint;
		private var _now:uint;
		private var _running:Boolean;
		private var existTime:uint;
		private var enterFrameTarget:Shape;
		private var progressDictionary:Array;
		private var len:int;
		private var _totalRepeat:uint;
		private var _currRepeat:uint;
		private var _repeatSignal:Signal;
		private var _isRepeat:Boolean;
		public function EasyTimer(_limit:uint = 1000,complete:Function = null)
		{
			_timeLimit = _limit;
			enterFrameTarget = new Shape();
			_ringSignal = new Signal();
			_timeSignal = new Signal(uint, uint, uint);
			_repeatSignal = new Signal(uint,uint);
			progressDictionary = [];
			len = 0;
			if(complete != null)
			{
				addComplete(complete);
			}
		}

		public function get repeatSignal():Signal
		{
			return _repeatSignal;
		}

		public function addComplete(func:Function):EasyTimer
		{
			_ringSignal.add(func);
			return this;
		}
		public function removeComplete(func:Function):EasyTimer
		{
			_ringSignal.remove(func);
			return this;
		}
		public function addRunning(func:Function):EasyTimer
		{
			_timeSignal.add(func);
			return this;
		}
		public function removeRunning(func:Function):EasyTimer
		{
			_timeSignal.remove(func);
			return this;
		}
		public function addRepeat(func:Function):EasyTimer
		{
			_repeatSignal.add(func);
			return this;
		}
		public function removeRepeat(func:Function):EasyTimer
		{
			_repeatSignal.remove(func);
			return this;
		}
		public function addProgress(name:String,per:Number,func:Function):EasyTimer
		{
//			progressDictionary[]
			removeProgress(name);
			var obj:Object = new Object();
			obj.name = name;
			obj.per = per;
			obj.func = func;
			progressDictionary.push(obj);
			len = progressDictionary.length;
			return this;
		}
		public function removeProgress(name:String):EasyTimer
		{
			for (var i:int = 0; i < len; i++) 
			{
				var obj:Object = progressDictionary[i];
				if (obj.name == name)
				{
					progressDictionary.splice(i, 1);
					len = progressDictionary.length;
					break;
				}
			}
			return this;
		}
		private function checkProgress(_now:uint):void
		{
			// TODO Auto Generated method stub
			var per:Number = _now / _timeLimit;
			//trace("per:",per);
			for (var i:int = 0; i < len; i++) 
			{
				var obj:Object = progressDictionary[i];
				//trace(obj.per);
				if(obj.per <= per)
				{
					obj.func(obj.name);
//					if(!_isRepeat)
//					{
						progressDictionary.splice(i, 1);
						len = progressDictionary.length;
//					}
					//checkProgress(_now);W
					break;
				}
			}
			
		}
		public function start(time:uint = 0):EasyTimer
		{
			if (time)
			{
				_timeLimit = time;
			}
			startTime = getTimer();
			existTime = 0;
			_running = true;
			enterFrameTarget.addEventListener(Event.ENTER_FRAME, onEnterCheck);
			return this;
		}
		public function repeat(time:uint = 0,_retime:uint = 0):EasyTimer
		{
			_currRepeat = 0;
			_totalRepeat = _retime;
			_isRepeat = true;
			start(time);
			return this;
		}
		public function stopRepeat(_stop:Boolean = true):EasyTimer
		{
			_isRepeat = false;
			if(_stop)
			{
				stop();
			}
			return this;
		}
		public function stop():EasyTimer
		{
			existTime = now;
			_running = false;
			enterFrameTarget.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
			return this;
		}
		private function onEnterCheck(e:Event):void 
		{
			checkProgress(_now);
			if (!remaining)
			{
				_running = false;
				_now = _timeLimit;
				_remaining = 0;
				existTime = _timeLimit;
				enterFrameTarget.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
				
				if(_isRepeat)
				{
					checkRepeat();
				}else
				{
					_ringSignal.dispatch();
				}
			}
			
			_timeSignal.dispatch(_now, _remaining, _timeLimit);
			
		}
		
		private function checkRepeat():void
		{
			// TODO Auto Generated method stub
			_currRepeat++;
			_repeatSignal.dispatch(_currRepeat,_totalRepeat);
			if(_totalRepeat == 0 || _currRepeat<_totalRepeat)
			{
				start();
			}else
			{
				_ringSignal.dispatch();
				_isRepeat = false;
			}
		}
		
		public function pause():EasyTimer
		{
			if (_running)
			{
				existTime = now;
				_running = false;
			}
			return this;
		}
		public function resume():EasyTimer
		{
			if (!_running)
			{
				_running = true;
				startTime = getTimer();
			}
			return this;
		}
		public function get timeLimit():uint 
		{
			return _timeLimit;
		}
		
		public function set timeLimit(value:uint):void 
		{
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
		
		public function get completeSignal():Signal
		{
			return _ringSignal;
		}
		
		public function get runningSignal():Signal
		{
			return _timeSignal;
		}
		
		public function get running():Boolean 
		{
			return _running;
		}

		public function get totalRepeat():uint
		{
			return _totalRepeat;
		}

		public function set totalRepeat(value:uint):void
		{
			_totalRepeat = value;
		}

		public function get currRepeat():uint
		{
			return _currRepeat;
		}


	}
}