package org.wang.website.factory 
{
	import org.wang.interfaces.IInventory;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseInventory implements IInventory 
	{
		protected var _className:Class;
		protected var _skinName:String;
		protected var _loaderName:String;
		protected var _name:String;
		public function BaseInventory() 
		{
			_loaderName = "mainCompnents";
			_name = "";
		}
		
		/* INTERFACE white.interfaces.IInventory */
		
		public function get className():Class 
		{
			return _className;
		}
		
		public function get skinName():String 
		{
			return _skinName;
		}
		
		public function get loaderName():String 
		{
			return _loaderName;
		}
		public function get name():String
		{
			return _name;
		}
	}

}