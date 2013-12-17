package org.wang.games.rhythmmaster.judge
{
	import org.wang.games.rhythmmaster.event.RhythmEvent;
	import org.wang.games.rhythmmaster.interfaces.IRhythmJudge;
	import org.wang.games.rhythmmaster.system.RhythmConfig;

	public class BaseRhythmJudge implements IRhythmJudge
	{

		private var levelData:Array;
		/**
		 * 评分类 提供分数 及判定评级
		 * 
		 */		
		
		private var totalLevel:uint;
		
		public function BaseRhythmJudge(arr:Array)
		{
			levelData = arr;
			totalLevel = arr.length;
		}
		
		/**
		 * 
		 * @param e
		 * @return 评判等级
		 * 
		 */		
		public function judgeLevel(e:RhythmEvent):uint
		{
			var n:uint = 0;
			if(!e.miss)
			{
				for (var i:int = 0; i < totalLevel; i++) 
				{
					if(e.timeDetail < levelData[i])
					{
						return i+1;
					}
				}
			}
			return n;
		}
		
		/**
		 * 
		 * @param e
		 * @return 评判分数
		 * 
		 */		
		public function judgeScore(e:RhythmEvent):uint
		{
			if(e.miss)
			{
				return 0;
			}
			return RhythmConfig.maxCheckTime-e.timeDetail;
			
			
			
//			return 0;
			
		}
	}
}