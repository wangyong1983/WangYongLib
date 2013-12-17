package org.wang.interfaces
{
	import flash.geom.Point;
	
	/**
	 * ToolTip皮肤类接口
	 * @author Leo.wang
	 */
	public interface IToolTipSkin extends IView
	{
		//需要显示的Tip文字 
		function set tipText(s:String):void;
	}
	
}