package org.wang.utils.preloader
{
	import flash.utils.Dictionary;

	public class PreLoaderManager
	{
		static private var distanceDictionary:Dictionary = new Dictionary();
		
		static public const AUTO:String = "auto";
		static public const SIZE_ASCENDING:String = "size_ascending";
		static public const SIZE_DESCENDING:String = "size_descending";
		static public const RANDOM:String = "random";
		
		static public function getInstance(s:String):PreLoaderManager
		{
			if(distanceDictionary[s] == null)
			{
				distanceDictionary[s] = new PreLoaderManager();
			}
			return distanceDictionary[s] as PreLoaderManager;
		}
		
		private var loaderDictionary:Dictionary;
		private var _loadType:String;
		public function PreLoaderManager()
		{
			loaderDictionary = new Dictionary(true);
			_loadType = AUTO;
		}
		public function start():void
		{
			
		}
		public function stop():void
		{
			
		}
		public function add(id:String,url:String,index:uint = 0):void
		{
			if(loaderDictionary[id] == null)
			{
				loaderDictionary[id] = new PreLoaderMember(url,index);
			}
		}
		public function getLoaderMember(id:String):PreLoaderMember
		{
			return loaderDictionary[id];
		}

		public function get loadType():String
		{
			return _loadType;
		}

		public function set loadType(value:String):void
		{
			_loadType = value;
		}

	}
}