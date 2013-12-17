package org.wang.games.rhythmmaster.interfaces
{
	import org.wang.games.rhythmmaster.event.RhythmEvent;

	public interface IRhythmJudge
	{
		function judgeLevel(e:RhythmEvent):uint;
		function judgeScore(e:RhythmEvent):uint;
	}
}