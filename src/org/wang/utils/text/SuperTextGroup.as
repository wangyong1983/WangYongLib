package org.wang.utils.text 
{
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class SuperTextGroup 
	{
		private var textFieldArray:Array;
		private var superTextArray:Array;
		private var _errorSignal:Signal;
		public function SuperTextGroup(arr:Array = null) 
		{
			
			superTextArray = arr?arr:[];
			if (arr)
			{
				initTextField();
			}
			_errorSignal = new Signal(int,String);
		}
		public function getSuperText(n:int):SuperTextField
		{
			return superTextArray[n] as SuperTextField;
		}
		public function addSuperText(tf:SuperTextField):SuperTextField
		{
			superTextArray.push(tf);
			tf.textField.tabIndex = superTextArray.length - 1;
			return tf;
		}
		private function initTextField():void 
		{
			var len:int = superTextArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				var tf:SuperTextField = superTextArray[i] as SuperTextField;
				if (tf)
				{
					tf.textField.tabIndex = i;
				}
			}
		}
		public function clear():SuperTextGroup
		{
			var len:int = superTextArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				var tf:SuperTextField = superTextArray[i] as SuperTextField;
				tf.clear();
			}
			return this;
		}
		public function getValue():Array
		{
			var len:int = superTextArray.length;
			var arr:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				arr.push(SuperTextField(superTextArray[i]).value);
			}
			return arr;
		}
		public function checkNum():Boolean
		{
			var len:int = superTextArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				var stf:SuperTextField = superTextArray[i] as SuperTextField;
				if (stf)
				{
					if (!stf.checkInputNum())
					{
						_errorSignal.dispatch(i,stf.errorText);
						return false;
					}
				}
			}
			return true;
		}
		public function check():Boolean
		{
			var len:int = superTextArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				var stf:SuperTextField = superTextArray[i] as SuperTextField;
				if (!stf.check())
				{
					_errorSignal.dispatch(i,stf.errorText);
					return false;
				}
			}
			return true;
		}
		
		public function get errorSignal():Signal 
		{
			return _errorSignal;
		}
	}

}