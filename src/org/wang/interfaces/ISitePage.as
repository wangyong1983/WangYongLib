package org.wang.interfaces 
{
	import flash.display.DisplayObjectContainer;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface ISitePage extends IView
	{
		function get pageSignal():ISignal;
		function readyToAdd(o:Object = null):void;
		function readyToRemove(o:Object = null):void;
	}
	
}