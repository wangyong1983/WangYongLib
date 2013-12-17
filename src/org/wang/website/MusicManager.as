package org.wang.website 
{
	import com.greensock.TweenLite;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.data.MP3LoaderVars;
	
	import org.osflash.signals.Signal;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class MusicManager 
	{
		static private var _instance:MusicManager;
		private var mp3Player:MP3Loader;
		private var mp3List:Array;
		private var currVolume:Number;
		private var lastVolume:Number;
		private var _isMute:Boolean;
		private var _silence:Boolean;
		
		private var _silenceSignal:Signal;
		private var _muteSignal:Signal;
		static public function getInstance():MusicManager
		{
			if (_instance == null)
			{
				_instance = new MusicManager();
			}
			return _instance;
		}
		public function MusicManager() 
		{
			mp3List = [];
			currMusic = -1;
			_silence = false;
			_isMute = false;
			currVolume = 1;
			lastVolume = 1;
			_muteSignal = new Signal(Boolean);
			_silenceSignal = new Signal(Boolean);
		}
		public function addMusic(s:String):void
		{
			mp3List.push(s);
		}
		public function set volume(n:Number):void
		{
			if (!_silence)
			{
				setMp3Volume(n);
				
			}
			if (n > 0)
			{
				_isMute = false;
			}
			currVolume = n;
		}
		public function get volume():Number
		{
			return currVolume;
		}
		
		public function get isMute():Boolean 
		{
			return _isMute;
		}
		
		public function set isMute(value:Boolean):void 
		{
			_isMute = value;
			mute(value);
		}
		private function setMp3Volume(n:Number):void
		{
			if(mp3Player)
				TweenLite.to(mp3Player, 0.5, {volume:n } );
		}
		public function silence(value:Boolean):void 
		{
			_silence = value;
			if (_silence)
			{
				setMp3Volume(0);
				//lastVolume = currVolume;
				//currVolume = 0;
			}else
			{
				//currVolume = lastVolume;
				if (!_isMute)
				{
					setMp3Volume(currVolume);
				}
				
			}
			_silenceSignal.dispatch(_silence);
		}
		public function mute(b:Boolean):void
		{
			if (_isMute == b)
			{
				return;
			}
			_isMute = b;
			if (b)
			{
				lastVolume = currVolume;
				currVolume = 0;
				setMp3Volume(currVolume);
			}else
			{
				currVolume = lastVolume;
				if (!_silence)
				{
					setMp3Volume(currVolume);
				}
			}
			_muteSignal.dispatch(_isMute);
		}
		private var currMusic:int;
		public function load(autoPlay:Boolean = true):void
		{
			switchMusic(0);
			//currMusic = 0;
		}
		public function switchMusic(n:int,autoPlay:Boolean = true):void
		{
			trace("切换音乐:"+n);
			
			if (currMusic == n)
			{
				return;
			}
			if (!mp3List[n])
			{
				return;
			}
			currMusic = n;
			var loadVars:MP3LoaderVars = new MP3LoaderVars();
			loadVars.autoPlay(autoPlay);
			loadVars.repeat( -1);
			if (mp3Player) {
				mp3Player.unload();
			}
			trace("加载声音: "+mp3List[n]);
			mp3Player = new MP3Loader(mp3List[n], loadVars);
			//trace(mp3Player.url);
			mp3Player.volume = 0;
			if (!_silence && !_isMute)
			{
				//currVolume = mp3Player.volume;
				trace("当前音量:"+currVolume);
				setMp3Volume(currVolume);
			}
			mp3Player.load();
		}

		public function get silenceSignal():Signal
		{
			return _silenceSignal;
		}

		public function get muteSignal():Signal
		{
			return _muteSignal;
		}


	}

}