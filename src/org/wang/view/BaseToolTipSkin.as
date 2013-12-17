package org.wang.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.wang.interfaces.IToolTipSkin;
	
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class BaseToolTipSkin implements IToolTipSkin 
	{
		private var label:TextField;
		private var _viewSp:Sprite;
		private var _name:String;
		public function BaseToolTipSkin() 
		{
			super();
			_viewSp = new Sprite();
			label = new TextField();  
            label.autoSize = TextFieldAutoSize.LEFT;  
            label.selectable = false;  
            label.multiline = false;  
            label.wordWrap = false; 
            label.text = "提示信息";  
            label.x = 5;  
            label.y = 2;  
			_viewSp.addChild(label);  
            redraw();  
			_viewSp.mouseEnabled = _viewSp.mouseChildren = false;  
		}
		
		private function redraw():void 
		{
			var w:Number = 10 + label.width;  
            var h:Number = 4 + label.height;              
            _viewSp.graphics.clear();  
            _viewSp.graphics.beginFill(0x000000, 0.4);  
            _viewSp.graphics.drawRoundRect(3, 3, w, h, 5, 5);                
            _viewSp.graphics.moveTo(6, 3 + h);  
            _viewSp.graphics.lineTo(12, 3 + h);  
            _viewSp.graphics.lineTo(9, 8 + h);  
            _viewSp.graphics.lineTo(6, 3 + h);  
            _viewSp.graphics.endFill();  
            _viewSp.graphics.beginFill(0xffffff);  
            _viewSp.graphics.drawRoundRect(0, 0, w, h, 5, 5);  
            _viewSp.graphics.moveTo(3, h);  
            _viewSp.graphics.lineTo(9, h);  
            _viewSp.graphics.lineTo(6, 5 + h);  
            _viewSp.graphics.lineTo(3, h);  
            _viewSp.graphics.endFill();  
		}
		public function set tipText(s:String):void
		{
			label.text = s;
			redraw();
		}
		
		public function get view():DisplayObjectContainer 
		{
			return _viewSp;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}

}