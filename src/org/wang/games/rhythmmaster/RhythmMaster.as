package org.wang.games.rhythmmaster
{
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	import org.wang.games.rhythmmaster.data.RhythmData;
	import org.wang.games.rhythmmaster.event.RhythmEvent;
	import org.wang.games.rhythmmaster.interfaces.IRhythmTrigger;
	import org.wang.games.rhythmmaster.system.RhythmTread;
	import org.wang.games.rhythmmaster.system.TreadControler;

	public class RhythmMaster
	{

		private var controlers:Array;
		
		private var _triggerSignal:Signal;
		
		private var _judgeSignal:Signal;
		public function RhythmMaster()
		{
			controlers = [];
			_triggerSignal = new Signal(uint,uint,RhythmData);
			
			_judgeSignal = new Signal(uint,RhythmEvent);
		}
		public function addGameThread(tread:RhythmTread,trigger:IRhythmTrigger):void
		{
			var controler:TreadControler = new TreadControler(tread,trigger);
			controler.id = controlers.length;
			controler.judgeSignal.add(onScoreJudge);
			controler.triggerSignal.add(onDataTrigger);
			controlers.push(controler);
		}
		
		private function onDataTrigger(_id:uint,time:uint,data:RhythmData):void
		{
			// TODO Auto Generated method stub
			_triggerSignal.dispatch(_id,time,data);
		}
		
		private function onScoreJudge(_id:uint,e:RhythmEvent):void
		{
			// TODO Auto Generated method stub
			//触发等级和评分 在此计算
			_judgeSignal.dispatch(_id,e);
			
//			if(e.miss)
//			{
//				trace(_id,"miss");
//			}else
//			{
//				trace(_id,e.timeDetail);
//			}
		}
		public function startGame():void
		{
			var len:int = controlers.length;
			for (var i:int = 0; i < len; i++) 
			{
				TreadControler(controlers[i]).start();
			}
		}
		public function pause():void
		{
			var len:int = controlers.length;
			for (var i:int = 0; i < len; i++) 
			{
				TreadControler(controlers[i]).pause();
			}
		}
		public function resume():void
		{
			var len:int = controlers.length;
			for (var i:int = 0; i < len; i++) 
			{
				TreadControler(controlers[i]).resume();
			}
		}
		public function stopGame():void
		{
			var len:int = controlers.length;
			for (var i:int = 0; i < len; i++) 
			{
				TreadControler(controlers[i]).stop();
			}
		}
		public function clearThread():void
		{
			var len:int = controlers.length;
			for (var i:int = 0; i < len; i++) 
			{
				TreadControler(controlers[i]).destroy();
			}
			controlers = [];
		}

		public function get triggerSignal():Signal
		{
			return _triggerSignal;
		}

		public function get judgeSignal():Signal
		{
			return _judgeSignal;
		}


	}
}