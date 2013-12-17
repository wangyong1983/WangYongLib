package org.wang.sound 
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasySoundComposer 
	{
		private var _inputByteArray:ByteArray;
		private var waveEncoder:WaveEncoder;
		private var completeSignal:Signal;
		public function EasySoundComposer(volume:Number = 1) 
		{
			_inputByteArray = new ByteArray();
			waveEncoder = new WaveEncoder(volume);
			//if (len)
			//{
				//addEmptySound(len);
			//}
		}
		private function addEmptySound(len:Number,start:Number = 0):void
		{
			var startPosition:int = getSoundLenthByTime(start);
			if (_inputByteArray.length <= startPosition)
			{
				_inputByteArray.position = startPosition;
			}
			for (var i:int = 0; i < len; i++) 
			{
				_inputByteArray.writeFloat(0);
			}
		}
		private function getSoundLenthByTime(n:Number):int
		{
			return n * 1000 * 44.1 * 2;
		}
		public function addMp3Sound(sound:Sound,position:Number = -1):void
		{
			var byte:ByteArray = new ByteArray();
			sound.extract(byte, sound.length * 44.1, position);
			addByteSound(byte);
			//return _inputByteArray;
		}
		public function addByteSound(byte:ByteArray):void
		{
			byte.position = 0;
			
			trace("添加声音:", byte.length)
			
			_inputByteArray.position = _inputByteArray.length;
			while (byte.bytesAvailable)
			{
				_inputByteArray.writeFloat(byte.readFloat());
			}
			trace("添加完毕:",_inputByteArray.length)
			//return _inputByteArray;
		}
		public function addByteSoundTo(byte:ByteArray, sPosition:Number):ByteArray
		{
			return null;
		}
		public function waveOutput():ByteArray
		{
			return waveEncoder.encode(_inputByteArray);
		}
		public function byteOutput():ByteArray
		{
			var byte:ByteArray = new ByteArray();
			_inputByteArray.position = 0;
			while (_inputByteArray.bytesAvailable)
			{
				byte.writeFloat(_inputByteArray.readFloat());
			}
			
			return byte;
		}
	}

}