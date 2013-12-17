package org.wang.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	
	import org.wang.events.EasyButtonEvent;
	import org.wang.events.EasyMenuEvent;

	public class EasyMenu extends EventDispatcher
	{
		protected var isLock:Boolean;
		protected var currButton:int;
		protected var totalButton:int;
		protected var mainMovie:DisplayObjectContainer;
		protected var baseName:String;
		protected var _onlyActive:Boolean;
		private var _menuEnabled:Boolean;
		private var dictionory:Dictionary;
		private var _currButtonID:int;
		private var _visible:Boolean;
		private var _clickSignal:Signal;
		public function EasyMenu(mc:DisplayObjectContainer,name:String,num:uint = 0,isL:Boolean = false,def:int=-1)
		{
			_clickSignal = new Signal(int);
			isLock = isL;
			currButton = def;
			mainMovie = mc;
			totalButton = num;
			baseName = name;
			_onlyActive = false;
			dictionory = new Dictionary(true);
			for(var i:uint=0;i<num;i++){
				if(mc.getChildByName(name+i) as MovieClip){
					var eb:EasyButton = new EasyButton(mc.getChildByName(name+i) as MovieClip);
					dictionory[baseName+i] = eb;
					//trace(eb)
					eb.ID = i;
					if(def == i){
						eb.isLock = true;
						eb.rollOver();
						currButton = i;
					}
					eb.addEventListener(EasyButtonEvent.ROLL_OVER,rollOver);
					eb.addEventListener(EasyButtonEvent.ROLL_OUT,rollOut);
					eb.addEventListener(EasyButtonEvent.CLICK,onClick);
				}else{
					trace("少一个_"+i);
				}
			}
			
		}
		public function setLock(b:Boolean):void
		{
			isLock = b;
		}
		private function rollOver(e:Event = null):void
		{
			if(_onlyActive){
				if(currButton != e.currentTarget.ID && currButton != -1){
					var eb:EasyButton = dictionory[baseName+currButton]
					eb.rollOut();
				}
			}
			var evt:EasyMenuEvent = new EasyMenuEvent(EasyMenuEvent.ROLL_OVER);
			evt.targetButton =e.currentTarget;
			dispatchEvent(evt);
		}
		private function rollOut(e:Event = null):void
		{
			if(_onlyActive){
				if(currButton != e.currentTarget.ID && currButton != -1){
					var eb:EasyButton = dictionory[baseName+currButton]
					eb.rollOver();
				}
			}
			var evt:EasyMenuEvent = new EasyMenuEvent(EasyMenuEvent.ROLL_OUT);
			evt.targetButton = e.currentTarget;
			dispatchEvent(evt);
		}
		private function onClick(e:Event = null):void
		{
			if(isLock){
				if(currButton != e.currentTarget.ID){
					if(currButton != -1){
						var eb:EasyButton = dictionory[baseName+currButton]
						eb.isLock = false;
						eb.rollOut();
						currButton = e.currentTarget.ID;
						var eb2:EasyButton = dictionory[baseName+currButton]
						eb2.isLock = true;
					}else{
						currButton = e.currentTarget.ID;
						var eb3:EasyButton = dictionory[baseName+currButton]
						eb3.isLock = true;
					}
				}
			}
			var evt:EasyMenuEvent = new EasyMenuEvent(EasyMenuEvent.CLICK);
			evt.targetButton = e.currentTarget;
			_clickSignal.dispatch(evt.targetButton.ID);
			dispatchEvent(evt);
			
		}

		public function set onlyActive(b:Boolean):void
		{
			_onlyActive = b;
		}

		public function get menuEnabled():Boolean
		{
			return _menuEnabled;
		}
		public function set menuEnabled(value:Boolean):void
		{
			_menuEnabled = value;
			for(var i:* in dictionory){
				dictionory[i].buttonEnabled = _menuEnabled;
			}
		}
		
		public function get buttonID():int { return currButton; }
		
		public function set buttonID(value:int):void 
		{
			//_currButton = value;
			if (isLock) {
				if (currButton != value) {
					if (value == -1) {
						var eb4:EasyButton = dictionory[baseName + currButton];
						eb4.isLock = false;
						eb4.rollOut();
						currButton = -1;
						return;
					}
					if(currButton != -1){
						var eb:EasyButton = dictionory[baseName+currButton]
						eb.isLock = false;
						eb.rollOut();
						currButton = value;
						var eb2:EasyButton = dictionory[baseName + currButton]
						eb2.rollOver();
						eb2.isLock = true;
					}else{
						currButton = value;
						var eb3:EasyButton = dictionory[baseName + currButton]
						eb3.rollOver();
						eb3.isLock = true;
					}
				}
			}
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			_visible = value;
			for(var i:* in dictionory){
				dictionory[i].targetMovie.visible = _visible;
			}
		}
		
		public function get clickSignal():Signal 
		{
			return _clickSignal;
		}

	}
}