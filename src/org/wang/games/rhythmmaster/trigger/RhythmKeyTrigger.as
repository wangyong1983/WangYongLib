package org.wang.games.rhythmmaster.trigger
{
	import com.hurlant.util.asn1.parser.nulll;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import org.osflash.signals.Signal;
	import org.wang.games.rhythmmaster.interfaces.IRhythmTrigger;
	import org.wang.key.KeyTrigger;

	public class RhythmKeyTrigger implements IRhythmTrigger
	{
		private var trigger:KeyTrigger;

		private var _upSignal:Signal;

		private var _downSignal:Signal;
		
		private var isDown:Boolean;
		
		private var _id:int;
		public function RhythmKeyTrigger(s:Stage,n:int)
		{
			trigger = new KeyTrigger(s);
			trigger.addDownTrigger(n,onKeyDown);
			trigger.addUpTrigger(n,onKeyUp);
			
			_downSignal = new Signal(int);
			_upSignal = new Signal(int);
			isDown = false;
			
		}
		public function open():void
		{
			trigger.open();
			isDown = false;
		}
		public function close():void
		{
			trigger.close();
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			_upSignal.dispatch(_id);
			isDown = false;
		}
		public function destroy():void
		{
			_upSignal.removeAll();
			_downSignal.removeAll();
			trigger.close();
			trigger = null;
			
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			if(!isDown)
			{
				_downSignal.dispatch(_id);
				isDown = true;
			}
		}

		public function get upSignal():Signal
		{
			return _upSignal;
		}

		public function get downSignal():Signal
		{
			return _downSignal;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}


	}
}