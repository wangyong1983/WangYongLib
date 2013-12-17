package org.wang.utils.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import org.osflash.signals.Signal;
	import org.wang.view.BaseView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SuperTextField 
	{
		private var _textField:TextField
		private var _defaultTip:String;
		private var _allowedEnter:Boolean;
		private var enterSignal:Signal;
		private var _allowedSpace:Boolean;
		private var _inputSignal:Signal;
		private var _max:uint;
		private var _min:uint;
		private var _errorText:String;
		private var _password:Boolean;
		private var _checkFunction:Function;
		public function SuperTextField(v:TextField) 
		{
			defaultTip = v.text;
			_textField = v;
			_textField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			_textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			enterSignal = new Signal();
			_inputSignal = new Signal(String);
			max = int.MAX_VALUE;
			min = 0;
			_password = false;
		}
		public function inputLimit(n:uint, m:uint):SuperTextField
		{
			min = n;
			max = m;
			return this;
		}
		public function restrict(s:String):SuperTextField
		{
			_textField.restrict = s;
			return this;
		}
		public function get value():String
		{
			if (textField.text == defaultTip)
			{
				return "";
			}else
			{
				return textField.text;
			}
		}
		public function checkInputNum():Boolean 
		{
			var len:int = value.length;
			if (len < min || len > max)
			{
				_errorText = "请至少输入"+min+"个字符";
				return false;
			}else
			{
				return true;
			}
		}
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.ENTER:
					doEnter();
					break;
				case Keyboard.SPACE:
					doSpace();
					break;
			}
			_inputSignal.dispatch(_textField.text.charAt(_textField.text.length - 1));
		}
		
		private function doSpace():void 
		{
			if (!_allowedSpace)
			{
				_textField.text = _textField.text.replace(" ","");
			}
		}
		public function clear():SuperTextField
		{
			_textField.text = defaultTip;
			return this;
		}
		private function doEnter():void 
		{
			if (!_allowedEnter)
			{
				_textField.text = _textField.text.replace("\n","");
			}
			enterSignal.dispatch();
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			if (_textField.text == "")
			{
				_textField.text = defaultTip;
			}
			if (_password)
			{
				if (_textField.text == defaultTip)
				{
					_textField.displayAsPassword = false;
				}else
				{
					_textField.displayAsPassword = true;
				}
			}
		}
		
		private function onFocusIn(e:FocusEvent):void 
		{
			if (_textField.text == defaultTip)
			{
				_textField.text = "";
			}
			if (_password)
			{
				_textField.displayAsPassword = true;
			}
		}
		
		public function get allowedEnter():Boolean 
		{
			return _allowedEnter;
		}
		
		public function set allowedEnter(value:Boolean):void 
		{
			_allowedEnter = value;
		}
		
		public function get allowedSpace():Boolean 
		{
			return _allowedSpace;
		}
		
		public function set allowedSpace(value:Boolean):void 
		{
			_allowedSpace = value;
		}
		
		public function get inputSignal():Signal 
		{
			return _inputSignal;
		}
		public function get errorText():String
		{
			return _errorText;
		}
		public function check():Boolean
		{
			if (_checkFunction != null)
			{
				return _checkFunction(value);
			}
			return true;
		}
		
		public function get max():uint 
		{
			return _max;
		}
		
		public function set max(value:uint):void 
		{
			_max = value;
			_textField.maxChars = value;
		}
		
		public function get min():uint 
		{
			return _min;
		}
		
		public function set min(value:uint):void 
		{
			_min = value;
		}
				
		public function get password():Boolean 
		{
			return _password;
		}
		
		public function set password(value:Boolean):void 
		{
			_password = value;
			//_textField.displayAsPassword = true;
		}
		
		public function get textField():TextField 
		{
			return _textField;
		}
		
		public function set checkFunction(value:Function):void 
		{
			_checkFunction = value;
		}

		public function get defaultTip():String
		{
			return _defaultTip;
		}

		public function set defaultTip(value:String):void
		{
			_defaultTip = value;
		}

	}

}