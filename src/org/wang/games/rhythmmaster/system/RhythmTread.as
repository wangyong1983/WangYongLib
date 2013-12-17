package org.wang.games.rhythmmaster.system
{
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	import org.wang.games.rhythmmaster.data.RhythmData;
	import org.wang.key.KeyTrigger;
	import org.wang.utils.EasyTimer;

	public class RhythmTread
	{


		private var treadTimer:EasyTimer;
		
		private var gameData:Array;
		
		private var advanceTime:uint;
		static private var _advanceTime:Number;
		
		private var head:uint;
		private var currData:RhythmData;
		private var _triggerSignal:Signal;
		public function RhythmTread()
		{
			
			treadTimer = new EasyTimer();
			treadTimer.runningSignal.add(onTimeRunning);
			gameData = [];
			head = 0;
			currData = null;
			_triggerSignal = new Signal(RhythmData);
		}
		
		private function onTimeRunning(_now:uint,_remeaning:uint,_total:uint):void
		{
			// TODO Auto Generated method stub
			if(currData.time - advanceTime <=_now)
			{
//				trace("head:",head,"弹出",currData.time,_now - advanceTime);
				_triggerSignal.dispatch(currData);
				if(head < gameData.length -1)
				{
					head++;
					currData = gameData[head];
				}else
				{
					treadTimer.stop();
				}
			}
		}
		public function clearData():void
		{
			gameData = [];
		}
		public function addData(rData:RhythmData):void
		{
			gameData.push(rData);
		}
		public function destroy():void
		{
			treadTimer.completeSignal.removeAll();
			treadTimer.repeatSignal.removeAll();
			treadTimer.runningSignal.removeAll();
			treadTimer.stop();
			treadTimer.stopRepeat();
		}
		public function start(time:Number):void
		{
			head = 0;
			advanceTime = RhythmConfig.advanceTime/RhythmConfig.rate;
			currData = gameData[head];
			treadTimer.start(time);
		}
		public function stop():void
		{
			treadTimer.stop();
		}
		public function pause():void
		{
			treadTimer.pause();
		}
		public function resume():void
		{
			treadTimer.resume();
		}

		public static function get advanceTime():Number
		{
			return _advanceTime;
		}

		public static function set advanceTime(value:Number):void
		{
			_advanceTime = value;
		}

		public function get triggerSignal():Signal
		{
			return _triggerSignal;
		}


	}
}