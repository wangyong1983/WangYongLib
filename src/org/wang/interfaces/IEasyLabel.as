package org.wang.interfaces 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IEasyLabel extends IView
	{
		function set label(s:String):void;
		function get label():String;
		function set data(d:*):void;
		function get data():*;
		function set id(n:int):void;
		function get id():int;
		function get clickSignal():Signal;
	}
	
}