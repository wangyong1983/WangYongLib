package org.wang.interfaces 
{
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IPopwindow extends IView
	{
		function get closeSignal():Signal;
		function get autoAlign():Boolean;
		function get alignRect():Rectangle;
		function set vars(o:*):void;
	}
	
}