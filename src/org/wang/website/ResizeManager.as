package org.wang.website 
{
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Leo.wang
	 */
	public class ResizeManager 
	{
		private var _stage:Stage;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		private var _minWidth:Number;
		private var _minHeight:Number;
		
		static private var instance:ResizeManager;
		public var resizeSignal:Signal;
		static public function getInstance():ResizeManager
		{
			if (instance == null)
			{
				instance = new ResizeManager();
			}
			return instance;
		}
		public function stageState(s:String):void
		{
			//_stage.displayState = StageDisplayState.FULL_SCREEN;
			_stage.displayState = s;
		}
		public function ResizeManager() 
		{
			resizeSignal = new Signal(Number,Number);
			_maxWidth = Number.MAX_VALUE;
			_maxHeight = Number.MAX_VALUE;
			_minWidth = 550;
			_minHeight = 400;
		}
		public function update():void
		{
			onResize();
		}
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function set stage(value:Stage):void 
		{
			_stage = value;
			initListener();
		}
		
		public function get stageWidth():Number 
		{
			return _stageWidth;
		}
		
		public function get stageHeight():Number 
		{
			return _stageHeight;
		}
		
		public function get maxWidth():Number 
		{
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void 
		{
			_maxWidth = value;
			onResize();
		}
		
		public function get maxHeight():Number 
		{
			return _maxHeight;
		}
		
		public function set maxHeight(value:Number):void 
		{
			_maxHeight = value;
			onResize();
		}
		
		public function get minWidth():Number 
		{
			return _minWidth;
		}
		
		public function set minWidth(value:Number):void 
		{
			_minWidth = value;
			onResize();
		}
		
		public function get minHeight():Number 
		{
			return _minHeight;
		}
		
		public function set minHeight(value:Number):void 
		{
			_minHeight = value;
			onResize();
		}
		
		private function initListener():void 
		{
			_stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		private function onResize(e:Event = null):void 
		{
			_stageWidth = _stage.stageWidth;
			_stageHeight = _stage.stageHeight;
			_stageWidth = (_stageWidth > _maxWidth)?_maxWidth:_stageWidth;
			_stageHeight = (_stageHeight > _maxHeight)?_maxHeight:_stageHeight;
			_stageWidth = (_stageWidth < _minWidth)?_minWidth:_stageWidth;
			_stageHeight = (_stageHeight < _minHeight)?_minHeight:_stageHeight;
			resizeSignal.dispatch(_stageWidth,_stageHeight);
		}
		
	}

}