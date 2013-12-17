package org.wang.games.rhythmmaster.system
{
	import org.wang.games.rhythmmaster.data.RhythmData;
	import org.wang.games.rhythmmaster.event.RhythmEvent;
	import org.wang.games.rhythmmaster.interfaces.IRhythmProcess;

	public class TapProcess implements IRhythmProcess
	{

		private var event:RhythmEvent;
		public function TapProcess(rData:RhythmData,time:uint)
		{
			event = new RhythmEvent(RhythmEvent.CALCULATE);
			event.timeDetail = Math.abs(rData.time - time);
		}
		public function calculate():RhythmEvent
		{
			return event;
		}
	}
}