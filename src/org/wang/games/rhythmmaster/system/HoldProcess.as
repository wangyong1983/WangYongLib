package org.wang.games.rhythmmaster.system
{
	import org.osflash.signals.Signal;
	import org.wang.games.rhythmmaster.data.RhythmData;
	import org.wang.games.rhythmmaster.event.RhythmEvent;
	import org.wang.games.rhythmmaster.interfaces.IRhythmProcess;
	import org.wang.utils.EasyTimer;

	public class HoldProcess implements IRhythmProcess
	{

		private var _updateSignal:Signal;
		
		private var _deadSignal:Signal;
		private var holdTimer:EasyTimer;
		private var deadTimer:EasyTimer;

		private var event:RhythmEvent;
		/**
		 * 
		 * @param rData
		 * @param time
		 * 持续触发处理类 此类数据不能即时判定 需等待Up事件结算
		 */		
		public function HoldProcess(rData:RhythmData,time:uint)
		{
			_updateSignal = new Signal(HoldProcess);
			_deadSignal = new Signal();
			
			holdTimer = new EasyTimer();
			deadTimer = new EasyTimer();
			
			var repeatInterval:uint = RhythmConfig.holdInterval/RhythmConfig.rate;
			var repeatCount:uint = Math.ceil(rData.holdTime/RhythmConfig.holdInterval);
			holdTimer.repeat(repeatInterval,repeatCount);
			holdTimer.repeatSignal.add(onRepeat);
			
			
			var deadTime:uint = rData.holdTime + (rData.time - time);
			deadTimer.start(deadTime).completeSignal.addOnce(onDead);
			
			
			event = new RhythmEvent(RhythmEvent.CALCULATE);
			event.timeDetail = Math.abs(rData.time - time);
		}
		
		private function onRepeat(curr:uint,total:uint):void
		{
			// TODO Auto Generated method stub
			event.timeDetail = 0;
			_updateSignal.dispatch(this);
		}
		
		private function onDead():void
		{
			// TODO Auto Generated method stub
			destroy();
		}
		public function destroy():void
		{
			holdTimer.stopRepeat();
			holdTimer.repeatSignal.removeAll();
			holdTimer.stop();
			holdTimer = null;
			deadTimer.stop();
			deadTimer.completeSignal.removeAll();
			deadTimer = null;
			event = null;
			_updateSignal.removeAll();
			_deadSignal.removeAll();
			_updateSignal = null;
			_deadSignal = null;
		}
		public function calculate():RhythmEvent
		{
			return event;
		}

		public function get updateSignal():Signal
		{
			return _updateSignal;
		}

		public function get deadSignal():Signal
		{
			return _deadSignal;
		}


		//在Miss之前按住 即相当于一次Perfect 按持续时间触发Perfect 在大于Miss时间之前松手为整体Miss
	}
}