package org.wang.interfaces.games 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IEasyGame 
	{
		function startGame():void
		function stopGame():void
		function pauseGame():void
		function resumeGame():void
		function gameReady():void
		function gameLose():void
		function gameWin():void
		function get gameOverSignal():Signal
		function get gameStateSignal():Signal
		function get gameScore():Number
		function set gameTiming(n:int):void
		function get gameTiming():int
		function get gameState():String
	}
	
}