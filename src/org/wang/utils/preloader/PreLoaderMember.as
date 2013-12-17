package org.wang.utils.preloader
{
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.core.LoaderItem;
	
	import org.osflash.signals.Signal;
	

	public class PreLoaderMember
	{
		private var _index:uint;
		private var loader:LoaderItem;
		
		private var _startSignal:Signal;
		private var _completeSignal:Signal;
		public function PreLoaderMember(url:String,index:uint = 0)
		{
			_index = index;
			_startSignal = new Signal(PreLoaderMember);
			_completeSignal = new Signal(PreLoaderMember);
			var type:String = url.slice(url.length-4).toLowerCase();
			switch(type)
			{
				case "flv":
				case "mp4":
				case "f4v":
					loader = new VideoLoader(url);
					break;
				case "mp3":
					loader = new MP3Loader(url);
					break;
				case "swf":
					loader = new SWFLoader(url);
					break;
			}
		}
		public function preLoad():void
		{
			if(loader.bytesLoaded == 0)
			{
				loader.load();
			}else
			{
				if(loader.paused)
				{
					loader.resume();
				}
			}
		}
		public function open():void
		{
			if(loader.bytesLoaded == 0)
			{
				loader.load();
			}else
			{
				if(loader.paused)
				{
					loader.resume();
				}
			}
		}
		public function pause():void
		{
			loader.pause();
		}
		public function resume():void
		{
			if(loader.bytesLoaded == 0)
			{
				loader.load();
			}else
			{
				if(loader.paused)
				{
					loader.resume();
				}
			}
		}
		public function close():void
		{
			loader.cancel();
		}
		public function release():void
		{
			loader.dispose();
		}

		public function get startSignal():Signal
		{
			return _startSignal;
		}

		public function get completeSignal():Signal
		{
			return _completeSignal;
		}


	}
}