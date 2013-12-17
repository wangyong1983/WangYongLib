package org.wang.website.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IAlert;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseAlert extends BasePopWindow implements IAlert 
	{
		protected var textField:TextField;
		private var _text:String;
		public function BaseAlert(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		
		private function init():void 
		{
			textField = getChildTextFieldByName("_txt");
			//closeSignal = new Signal(IAlert);
			_vars = new Object();
		}
		
		/* INTERFACE org.wang.interfaces.IAlert */
		
		public function set text(value:String):void 
		{
			_text = value;
			if (textField)
				textField.text = _text;
		}
		
		
	}

}