package org.wang.sound
{
	import de.popforge.audio.output.Audio;
	import de.popforge.audio.output.SoundFactory;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.Signal;

	public class SoundAdder
	{
		//private var souceByte:ByteArray;
		//private var targetByte:ByteArray;
		private var _completeSignal:Signal;
		private var waveEncoder:WaveEncoder;
		public function SoundAdder()
		{
			_completeSignal = new Signal(Sound);
			waveEncoder = new WaveEncoder();
		}
		/**
		 * 
		 * @param source 源音频Sound对象
		 * @param target 要添加的音频Sound对象
		 * @param position 添加到的位置 毫秒
		 * 
		 */		
		public function addSound(source:Sound,target:Sound,position:Number = 0):Signal
		{
			var souceByte:ByteArray = new ByteArray();
			var targetByte:ByteArray = new ByteArray();
			source.extract(souceByte,source.length * 44100);
			target.extract(targetByte,target.length * 44100);
			trace(source.length);
			trace(target.length);
			trace(source.length * 44100);
			trace(target.length * 44100);
			trace("源数据长度:",souceByte.length);
			trace("目标数据长度:",targetByte.length);
			
			if(source.length < position)
			{
				position = source.length*44100;
			}else
			{
				position *= 44100;
			}
			position = (position > souceByte.length)?souceByte.length:position;
			trace(position);
			var soundbyte:ByteArray = addBytes(souceByte, targetByte, position);
			//trace("完成:", soundbyte.length);
			SoundFactory.fromByteArray(waveEncoder.encode(soundbyte), 2, Audio.BIT16, Audio.RATE44100, onComplete);
			return _completeSignal;
		}
		
		private function onComplete(sound:Sound):void
		{
			// TODO Auto Generated method stub
			_completeSignal.dispatch(sound);
		}
		private function addEmptyBytes(source:ByteArray,length:uint):ByteArray
		{
			source.position = source.length-1;
			for (var i:int = 0; i < length; i++) 
			{
				source.writeFloat(0);
			}
			
			
			
			
			return source;
		}
		public function addBytesToButtom(source:ByteArray, target:ByteArray, position:uint = 0):ByteArray
		{
			return addBytes(source, target, source.length);
		}
		public function addBytes(source:ByteArray,target:ByteArray,position:uint = 0):ByteArray
		{
			source.position = position;
			target.position = 0;
			var len:int = target.length/4;
			var n:Number;
			for (var i:int = 0; i < len; i++) 
			{
				
				var m:Number = target.readFloat();
				if(source.bytesAvailable)
				{
					n = source.readFloat();
					source.position -= 4;
					source.writeFloat((n+m)/2);
				}else
				{
					source.writeFloat(m);
				}
			}
			return source;
		}
		private function getSoundLenthByTime(n:Number):int
		{
			return n * 1000 * 44.1 * 2;
		}
		public function get completeSignal():Signal
		{
			return _completeSignal;
		}

	}
}