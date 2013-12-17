package org.wang.math
{
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.Signal;

	public class ContrastByteArray
	{
		static private var _step:int = 5000;
		private var _completeSignal:Signal;
		private var byte0:ByteArray;
		private var byte1:ByteArray;
		private var len0:int;
		private var len1:int;
		private var engine:Shape;
		private var result:Number;
		public function ContrastByteArray(arr1:ByteArray,arr2:ByteArray)
		{
			byte0 = arr1;
			byte1 = arr2;
			len0 = arr1.length;
			len1 = arr2.length;
			_completeSignal = new Signal(Number);
			engine = new Shape();
			result = 0;
		}
		
		protected function onCaculate(event:Event):void
		{
			// TODO Auto-generated method stub
			for (var i:int = 0; i < _step; i++) 
			{
				if(byte0.bytesAvailable && byte1.bytesAvailable)
				{
					var temp0:Number = byte0.readFloat();
					var temp1:Number = byte1.readFloat();
					
					result = (result + (temp0-temp1))/2;
//					trace(temp0,temp1,result);
				}else
				{
					done();
					break;
					
				}
			}
			
		}
		
		private function done():void
		{
			// TODO Auto Generated method stub
			engine.removeEventListener(Event.ENTER_FRAME,onCaculate);
			_completeSignal.dispatch(result);
		}
		public function start():Signal
		{
			byte0.position = 0;
			byte1.position = 0;
			engine.addEventListener(Event.ENTER_FRAME,onCaculate);
			
			return _completeSignal;
		}

		public function get completeSignal():Signal
		{
			return _completeSignal;
		}

		public static function get step():int
		{
			return _step;
		}

		public static function set step(value:int):void
		{
			_step = value;
		}


	}
}