package org.wang.compnents.label 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	import org.wang.interfaces.IEasyLabel;
	import org.wang.view.BaseView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyLabel extends BaseView implements IEasyLabel 
	{
		private var labelTField:TextField;
		private var _data:*;
		private var _label:String;
		private var _id:int;
		private var _clickSignal:Signal;
		private var _defaultTextFormat:TextFormat;
		public function EasyLabel(v:DisplayObjectContainer) 
		{
			super(v);
			init();
		}
		
		private function init():void 
		{
			labelTField = getChildTextFieldByName("_label");
			_clickSignal = new Signal(IEasyLabel);
			view.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void 
		{
			_clickSignal.dispatch(this);
		}
		
		/* INTERFACE org.wang.interfaces.IEasyLabel */
		
		public function set label(value:String):void 
		{
			_label = value;
			labelTField.text = _label;
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function get clickSignal():Signal 
		{
			return _clickSignal;
		}
		
		public function get defaultTextFormat():TextFormat 
		{
			return _defaultTextFormat;
		}
		
		public function set defaultTextFormat(value:TextFormat):void 
		{
			_defaultTextFormat = value;
			labelTField.defaultTextFormat = value;
		}
		
	}

}