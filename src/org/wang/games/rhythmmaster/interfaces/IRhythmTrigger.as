package org.wang.games.rhythmmaster.interfaces
{
	import org.osflash.signals.Signal;

	public interface IRhythmTrigger
	{
		function open():void
		function close():void
		function destroy():void
		function get upSignal():Signal
		function get downSignal():Signal
	}
}