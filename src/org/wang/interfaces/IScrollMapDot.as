package org.wang.interfaces 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IScrollMapDot extends IView
	{
		function get rect():Rectangle;
		function set show(b:Boolean):void;
		function get show():Boolean;
		function set x(n:Number):void
		function get x():Number
		function set y(n:Number):void
		function get y():Number
	}
	
}