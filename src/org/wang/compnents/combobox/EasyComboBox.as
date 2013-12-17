package org.wang.compnents.combobox 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	import org.wang.compnents.list.EasyList;
	import org.wang.events.EasyButtonEvent;
	import org.wang.interfaces.IEasyLabel;
	import org.wang.utils.EasyButton;
	import org.wang.view.BaseView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyComboBox extends BaseView 
	{
		private var mainButton:EasyButton;
		private var _mainLabel:TextField;
		private var easyList:EasyList;
		private var _element:Class;
		public var clickSignal:Signal;
		private var _selected:int;
		private var arrData:Vector.<IEasyLabel>;
		private var _defaultTextFormat:TextFormat;
		public function EasyComboBox(v:DisplayObjectContainer) 
		{
			super(v);
			mainButton = new EasyButton(getChildMovieByName("_main"));
			easyList = new EasyList(getChildSpriteByName("_list"));
			_mainLabel = getChildTextFieldByName("_mainLabel");
			_mainLabel.mouseEnabled = false;
			clickSignal = new Signal(IEasyLabel);
			mainButton.addEventListener(EasyButtonEvent.CLICK, onClick);
			easyList.view.visible = false;
			_selected = -1;
			arrData = new Vector.<IEasyLabel>;
		}
		private function onClick(e:EasyButtonEvent):void 
		{
			addListener();
		}
		public function set edit(b:Boolean):void
		{
			_mainLabel.mouseEnabled = b;
			if (b)
			{
				_mainLabel.type = TextFieldType.INPUT;
				_mainLabel.selectable = true;
				_mainLabel.alwaysShowSelection = true;
			}else
			{
				_mainLabel.type = TextFieldType.DYNAMIC;
				_mainLabel.alwaysShowSelection = false;
				_mainLabel.selectable = false;
			}
			
		}
		private function addListener():void 
		{
			if (easyList.view.visible)
			{
				removeListener();
			}else
			{
				easyList.mouseWheelEnabled = true;
				easyList.view.visible = true;
			}
		}
		public function open():void
		{
			easyList.mouseWheelEnabled = true;
			easyList.view.visible = true;
		}
		public function close():void
		{
			easyList.mouseWheelEnabled = false;
			easyList.view.visible = false;
		}
		public function clear():void
		{
			arrData.forEach(removeElement);
			easyList.clear();
		}
		
		private function removeElement(e:IEasyLabel):void 
		{
			e.clickSignal.removeAll();
		}
		public function set currLabel(s:String):void
		{
			_mainLabel.text = s;
		}
		public function get currLabel():String
		{
			return _mainLabel.text;
		}
		private function removeListener():void
		{
			easyList.mouseWheelEnabled = false;
			easyList.view.visible = false;
		}
		public function set currSelect(n:int):void
		{
			if (n > arrData.length || n < 0)
			{
				return;
			}
			_selected = n;
			_mainLabel.text = arrData[n].label;
		}
		public function get currSelect():int
		{
			return _selected;
		}
		public function addElement(e:IEasyLabel):void
		{
			easyList.add(e.view);
			arrData.push(e);
			e.clickSignal.add(onElementClick);
		}
		public function addArrayElement(a:Vector.<IEasyLabel>):void
		{
			var len:int = a.length;
			for (var i:int = 0; i < len; i++) 
			{
				addElement(a[i]);
			}
		}
		public function set arrayElement(a:Vector.<IEasyLabel>):void
		{
			clear();
			addArrayElement(a);
		}
		public function get selected():Object
		{
			if (_selected == -1)
			{
				return null;
			}
			return arrData[_selected];
		}
		private function onElementClick(e:IEasyLabel):void 
		{
			_mainLabel.text = e.label;
			_selected = e.id;
			removeListener();
			clickSignal.dispatch(e);
		}
		public function get length():int
		{
			return arrData.length;
		}
		
		public function get defaultTextFormat():TextFormat 
		{
			return _defaultTextFormat;
		}
		
		public function set defaultTextFormat(value:TextFormat):void 
		{
			_mainLabel.defaultTextFormat = value;
			_defaultTextFormat = value;
		}

		public function get mainLabel():TextField
		{
			return _mainLabel;
		}

	}

}