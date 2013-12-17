package org.wang.interfaces 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IPainterBoard 
	{
		function get view():Sprite
		function set brush(b:IBrush):void
		function get painting():BitmapData
		function clearUp():void
	}
	
}