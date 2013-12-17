package org.wang.games 
{
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	import org.wang.math.LimitInt;
	import org.wang.utils.EasyCountTimer;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class Roulette 
	{
		private var _startTime:int;
		private var _runTime:int;
		private var _overTime:int;
		private var _maxSpeed:int;
		private var _currRotation:LimitInt;
		private var _currSpeed:Number;
		private var enterFrameDispatcher:Sprite;
		private var keepTimer:EasyCountTimer;
		private var _overRotation:uint;
		private var _runingSignal:Signal;
		private var _turnedSignal:Signal;
		public function Roulette() 
		{
			init();
		}
		
		private function init():void 
		{
			_startTime = 2000;
			_runTime = 3000;
			_overTime = 7000;
			_maxSpeed = 50;
			_currRotation = new LimitInt(360, 0);
			_currSpeed = 0;
			_overRotation = 0;
			keepTimer = new EasyCountTimer(_runTime, false);
			keepTimer.ringSignal.add(onKeepComplete);
			enterFrameDispatcher = new Sprite();
			_runingSignal = new Signal(int);
			_turnedSignal = new Signal();
		}
		
		
		public function start():void
		{
			enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, onEnter);
			_currSpeed = 0;
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.vars.currSpeed = _maxSpeed;
			vars.onComplete(onStartComplete);
			TweenLite.to(this, _startTime/1000, vars);
		}
		private var obj:Object;
		private function onKeepComplete(e:EasyCountTimer):void 
		{
			enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, onEnter);
			obj = new Object();
			obj.rotation = _currRotation.value;
			
			//trace("准备结束"+obj.rotation);
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.vars.rotation = 360 * 5 + _overRotation;
			vars.ease(Linear.easeNone);
			vars.onComplete(_turnedSignal.dispatch).onUpdate(onOverUpdate,[obj]).ease(Circ.easeOut);
			TweenLite.to(obj, _overTime/1000, vars);
		}
		
		private function onOverUpdate(obj:Object):void 
		{
			_currRotation.value = obj.rotation;
			//trace(obj);
			_runingSignal.dispatch(_currRotation.value);
		}
		private function onStartComplete():void 
		{
			keepTimer.start();
		}
		public function get rotation():int
		{
			return _currRotation.value;
		}
		private function onEnter(e:Event):void 
		{
			_currRotation.plus(_currSpeed);
			_runingSignal.dispatch(_currRotation.value);
		}
		public function get startTime():int 
		{
			return _startTime;
		}
		
		public function set startTime(value:int):void 
		{
			_startTime = value;
		}
		
		public function get runTime():int 
		{
			return _runTime;
		}
		
		public function set runTime(value:int):void 
		{
			_runTime = value;
			keepTimer.timeLimit = _runTime;
		}
		
		public function get overTime():int 
		{
			return _overTime;
		}
		
		public function set overTime(value:int):void 
		{
			_overTime = value;
		}
		
		public function get maxSpeed():int 
		{
			return _maxSpeed;
		}
		
		public function set maxSpeed(value:int):void 
		{
			_maxSpeed = value;
		}
		
		public function get currSpeed():Number 
		{
			return _currSpeed;
		}
		
		public function set currSpeed(value:Number):void 
		{
			_currSpeed = value;
			//trace(_currSpeed);
		}
		
		public function get overRotation():uint 
		{
			return _overRotation;
		}
		
		public function set overRotation(value:uint):void 
		{
			_overRotation = value;
		}
		
		public function get runingSignal():Signal 
		{
			return _runingSignal;
		}
		
		public function get turnedSignal():Signal 
		{
			return _turnedSignal;
		}
		
	}

}