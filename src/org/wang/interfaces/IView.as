package org.wang.interfaces 
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IView 
	{
		function get view():DisplayObjectContainer;
		//function get parent():IView;
		function set name(s:String):void;
		function get name():String;
		//function addChild(v:IView):IView;
		//function getChildByName(s:String):IView;
	}
	
}