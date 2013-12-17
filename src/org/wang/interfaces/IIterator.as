package org.wang.interfaces 
{
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public interface IIterator 
	{
		function reset():void;
		function get hasNext():Boolean;
		function get next():Object;
	}
	
}