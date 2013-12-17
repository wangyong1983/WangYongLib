package org.wang.utils
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import org.wang.events.SwitchButtonEvent;
	
	/**
	 * ...
	 * @author wang yong
	 */
	public class SwitchButton extends EventDispatcher
	{
		private var _targetMovie:MovieClip;
		private var _isSwitch:Boolean;
		
		public function SwitchButton(mc:MovieClip) {
			_targetMovie = mc;
			mc.stop();
			_targetMovie.buttonMode = true;
			mc.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent = null):void 
		{
			var sbe:SwitchButtonEvent = new SwitchButtonEvent(SwitchButtonEvent.SWITCH_CLICK);
			sbe.switchFrame = 3 - _targetMovie.currentFrame;
			_targetMovie.gotoAndStop(3 - _targetMovie.currentFrame)
			_isSwitch = sbe.switchFrame == 1?false:true;
			dispatchEvent(sbe);
		}
		public function get targetMovie():MovieClip { return _targetMovie; }
		
		public function get isSwitch():Boolean { return _isSwitch; }
		
		public function set isSwitch(value:Boolean):void 
		{
			if (value != _isSwitch) {
				_isSwitch = value;
				_targetMovie.gotoAndStop(_isSwitch?2:1);
			}
		}
	}
	
}