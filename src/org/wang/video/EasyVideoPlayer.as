package org.wang.video 
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import org.osflash.signals.Signal;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyVideoPlayer 
	{
		private var _videoBox:Video;
		private var netStream:NetStream;
		private var netConnection:NetConnection;
		private var _soundVolume:Number;
		private var _currTime:Number;
		private var _totalTime:Number;
		private var _isPlaying:Boolean;
		private var _isPause:Boolean;
		private var _eventDispatcher:EventDispatcher;
		
		private var _buffering:Boolean = true;
		
		
		private var _loadingSignal:Signal;
		private var _onVideoPlaySignal:Signal;
		private var _onVideoCloseSignal:Signal;
		private var _playProgressSignal:Signal;
		private var _bufferingSignal:Signal
		
		private var eventSprite:Sprite;

		private var progress:ProgressEvent;
		
		
		
		public function EasyVideoPlayer(v:Video) 
		{
			_videoBox = v;
			_videoBox.smoothing = true;
			eventSprite = new Sprite();
			netConnection = new NetConnection();
			netConnection.connect(null);
			netStream = new NetStream(netConnection);
			netStream.client = new Object();
			netStream.client.onMetaData = onMetaData;
			netStream.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			_videoBox.attachNetStream(netStream);
			_soundVolume = netStream.soundTransform.volume;
			_eventDispatcher = new EventDispatcher();
			_isPlaying = false;
			_isPause = false;
			_loadingSignal = new Signal(ProgressEvent);
			_onVideoPlaySignal = new Signal();
			_onVideoCloseSignal = new Signal();
			_playProgressSignal = new Signal(Number);
			_bufferingSignal = new Signal(Boolean);
			progress = new ProgressEvent(ProgressEvent.PROGRESS);
		}

		public function get onVideoCloseSignal():Signal
		{
			return _onVideoCloseSignal;
		}

		public function get onVideoPlaySignal():Signal
		{
			return _onVideoPlaySignal;
		}

		private function statusHandler(e:NetStatusEvent):void 
		{
			/*NetStream.Play.Start
			NetStream.Buffer.Empty
			NetStream.Buffer.Full
			NetStream.Buffer.Empty
			NetStream.Buffer.Full
			NetStream.Buffer.Empty
			NetStream.Buffer.Full
			NetStream.Buffer.Flush
			NetStream.Play.Stop
			NetStream.Buffer.Empty
			NetStream.Buffer.Flush
			*/
			//trace(e.info.code);
			switch(e.info.code)
			{
				case "NetStream.Play.Stop":
					_isPlaying = false;
					_isPause = false;
					_onVideoCloseSignal.dispatch();
					break;
				case "NetStream.Play.Start":
					_isPlaying = true;
					_isPause = false;
					_onVideoPlaySignal.dispatch();
					break;
				case "NetStream.Buffer.Empty":
					_buffering = true;
					_bufferingSignal.dispatch(_buffering);
					break;
				case "NetStream.Buffer.Full":
					_buffering = false;
					_bufferingSignal.dispatch(_buffering);
					break;
			}
		}
		private function onMetaData(md:Object):void
		{
			_totalTime = md.duration;
		}
		public function playVideo(s:String,autoPlay:Boolean = true):void
		{
//			netStream.checkPolicyFile = true;
			netStream.play(s);
//			videoBox.
			if(!autoPlay)
			{
				netStream.pause();
				_isPlaying = true;
				_isPause = true;
			}else
			{
				_isPlaying = true;
				_isPause = false;
			}
			
			eventSprite.addEventListener(Event.ENTER_FRAME, onEnter);
			eventSprite.addEventListener(Event.ENTER_FRAME, onLoadEnter);
			_eventDispatcher.dispatchEvent(new Event(Event.OPEN));
//			_onVideoPlaySignal.dispatch();
		}
		public function stopVideo():void
		{
			_isPlaying = false;
			_isPause = false;
			netStream.close();
			_onVideoCloseSignal.dispatch();
		}
		public function seek(n:Number):void
		{
			var m:Number = Math.min(Math.max(n, 0), 1);
			if(_totalTime){
				netStream.seek(m*_totalTime);
			}
		}
		public function pause():void
		{
			if (_isPlaying && !_isPause) {
				netStream.pause();
				_isPause = true;
			}
		}
		public function 	constraintPause():void
		{
			netStream.pause();
			_isPause = true;
		}
		public function resume():void
		{
			if(_isPlaying && _isPause)
			{
				netStream.resume();
				_isPause = false;
			}
		}
		public function 	constraintResume():void
		{
			netStream.resume();
			_isPause = false;
		}
		private function onLoadEnter(e:Event):void 
		{
			
			progress.bytesLoaded = netStream.bytesLoaded;
			progress.bytesTotal = netStream.bytesTotal;
			_loadingSignal.dispatch(progress);
			
			_eventDispatcher.dispatchEvent(progress);
			//trace(progress.bytesLoaded);
			//trace(progress.bytesTotal);
			if (netStream.bytesLoaded >= netStream.bytesTotal) {
				eventSprite.removeEventListener(Event.ENTER_FRAME, onLoadEnter);
			}
		}
		
		private function onEnter(e:Event):void 
		{
			_currTime = netStream.time;
			var evt:Event = new Event("playProgress");
			_eventDispatcher.dispatchEvent(evt);
			_playProgressSignal.dispatch(_currTime/totalTime);
			//trace("playProgress");
		}
		public function mute(b:Boolean = true):void
		{
			if (!b) {
				var soundtransform:SoundTransform = new SoundTransform(_soundVolume);
				netStream.soundTransform = soundtransform;
			}else {
				
				var soundtransform2:SoundTransform = new SoundTransform(0);
				netStream.soundTransform = soundtransform2;
			}
		}
		public function get soundVolume():Number { return _soundVolume; }
		
		public function set soundVolume(value:Number):void 
		{
			var n:Number = Math.min(Math.max(value, 0),1);
			var soundtransform:SoundTransform = new SoundTransform(n);
			netStream.soundTransform = soundtransform;
			_soundVolume = value;
		}
		
		public function get currTime():Number { return _currTime; }
		
		public function get totalTime():Number { return _totalTime; }
		
		public function get isPlaying():Boolean { return _isPlaying; }
		
		public function get isPause():Boolean { return _isPause; }
		
		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}

		public function get loadingSignal():Signal
		{
			return _loadingSignal;
		}

		public function get playProgressSignal():Signal
		{
			return _playProgressSignal;
		}

		public function get bufferingSignal():Signal
		{
			return _bufferingSignal;
		}

		public function get videoBox():Video
		{
			return _videoBox;
		}


	}

}