package org.wang.interfaces 
{
	import flash.display.Stage;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.wang.website.view.BasePage;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface ISiteFactory 
	{
		function loadFactoryConfig(s:String):void
		function getSitePage(n:int):ISitePage
		function getClassInSWF(cname:String, loadername:String):Class
		function getPopWindow(inventory:IInventory, obj:* = null, isNew:Boolean = false):IPopwindow
		function getAlertWindow(inventory:IInventory, obj:* = null, isNew:Boolean = false):IAlert
		function get xmlData():XML
		function needPage(n:int):ISitePage
		function get needPageSignal():Signal
		function get pageClasses():Vector.<Class>
		function get onLoadStartSignal():Signal
		function get onLoadProgressSignal():Signal 
		function get onLoadCompleteSignal():Signal 
		function getDomain():String
		function getURL(s:String,b:Boolean = false):String
		function set stage(s:Stage):void
		function get stage():Stage;
	}
	
}