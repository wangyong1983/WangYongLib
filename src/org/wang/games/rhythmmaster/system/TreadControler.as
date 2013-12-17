package org.wang.games.rhythmmaster.system
{
	import com.hurlant.util.asn1.parser.nulll;
	
	import org.osflash.signals.Signal;
	import org.wang.games.rhythmmaster.data.RhythmData;
	import org.wang.games.rhythmmaster.event.RhythmEvent;
	import org.wang.games.rhythmmaster.interfaces.IRhythmTrigger;
	import org.wang.utils.EasyTimer;

	public class TreadControler
	{

		private var _tread:RhythmTread;

		private var _trigger:IRhythmTrigger;
		
		private var correctTimer:EasyTimer;
		
		private var dataQueue:Array;
		
		private var processQueue:Array;

		private var _judgeSignal:Signal;
		
		private var _triggerSignal:Signal;
		
		private var holdProcess:HoldProcess;
		
		private var _id:uint;
		public function TreadControler(tread:RhythmTread,trigger:IRhythmTrigger)
		{
			_tread = tread;
			_trigger = trigger;
			
			correctTimer = new EasyTimer();
			correctTimer.runningSignal.add(onCorrectCheck);
			_trigger.downSignal.add(onTriggerDown);
			_trigger.upSignal.add(onTriggerUp);
			_tread.triggerSignal.add(onTreadTrigger);
			dataQueue = [];
			processQueue = [];
			
			_judgeSignal = new Signal(uint,RhythmEvent);
			
			_triggerSignal = new Signal(uint,uint,RhythmData);
		}
		
		
		
		private function onTreadTrigger(rData:RhythmData):void
		{
			// TODO Auto Generated method stub
			//加入队列 等待触发 
//			trace("弹出",correctTimer.now,rData.time);
			dataQueue.push(rData);
			_triggerSignal.dispatch(_id,correctTimer.now,rData);
		}
		
		private function onTriggerUp(n:int):void
		{
			// TODO Auto Generated method stub
			onHoldProcessDead();
		}
		private function onHoldUpdate(progress:HoldProcess):void
		{
			// TODO Auto Generated method stub
			_judgeSignal.dispatch(_id,progress.calculate());
		}
		private function onHoldProcessDead():void
		{
			// TODO Auto Generated method stub
			if(holdProcess)
			{
				holdProcess.destroy();
				holdProcess = null;
			}
		}	
		private function onTriggerDown(n:int):void
		{
			// TODO Auto Generated method stub
//			trace(dataQueue.length);
			if(dataQueue.length)
			{
				var rData:RhythmData = dataQueue[0];
				
				if(Math.abs(rData.time - correctTimer.now) <= RhythmConfig.maxCheckTime)
				{
					calculate(rData,correctTimer.now);
					dataQueue.shift();
				}
			}
		}
		private function onCorrectCheck(_now:uint,_remeaning:uint,_total:uint):void
		{
			// TODO Auto Generated method stub
			if(dataQueue.length)
			{
				var rData:RhythmData = dataQueue[0];
				if(rData.time + RhythmConfig.missTime < correctTimer.now)
				{
					miss();
					dataQueue.shift();
				}
			}
		}
		
		private function miss():void
		{
			// TODO Auto Generated method stub
//			trace("miss",correctTimer.now);
			var event:RhythmEvent = new RhythmEvent(RhythmEvent.CALCULATE);
			event.miss = true;
			_judgeSignal.dispatch(_id,event);
		}
		//计算时间吻合度评分
		private function calculate(rData:RhythmData,time:uint):void
		{
			// TODO Auto Generated method stub
			if(rData.type == RhythmData.HOLD)
			{
				holdProcess = new HoldProcess(rData,time);
				_judgeSignal.dispatch(_id,holdProcess.calculate());
				holdProcess.updateSignal.add(onHoldUpdate);
				holdProcess.deadSignal.addOnce(onHoldProcessDead);
				return;
			}
			if(rData.type == RhythmData.TAP)
			{
				var tap:TapProcess = new TapProcess(rData,time);
				_judgeSignal.dispatch(_id,tap.calculate());
				return;
			}
		}
		
			
		
		public function start(totalTime:Number = 180000):void
		{
			correctTimer.start(totalTime);
			_tread.start(totalTime);
			_trigger.open();
		}
		public function stop():void
		{
			correctTimer.stop();
			_tread.stop();
			_trigger.close();
		}
		public function pause():void
		{
			correctTimer.pause();
			_tread.pause();
			_trigger.close();
		}
		public function resume():void
		{
			correctTimer.resume();
			_tread.resume();
			_trigger.open();
		}
		public function destroy():void
		{
			stop();
			_tread.destroy();
			_trigger.destroy();
			
		}

		public function get judgeSignal():Signal
		{
			return _judgeSignal;
		}

		public function get id():uint
		{
			return _id;
		}

		public function set id(value:uint):void
		{
			_id = value;
		}

		public function get triggerSignal():Signal
		{
			return _triggerSignal;
		}


	}
}