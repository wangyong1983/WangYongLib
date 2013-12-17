/**
* ...
* @author Default
* @version 0.1
*/

package org.wang.movie{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.wang.event.DynamicEvent;
	public class DragMovie extends EventDispatcher {
		public static const MOUSE_DRAG:String = "MOUSE_DRAG";
		public static const MOUSE_DRAG_STOP:String = "MOUSE_DRAG_STOP";
		private var _maxLeft:Number = 0;
		//最大左范围
		private var _maxRight:Number = 0;
		//最大右范围
		private var _maxUp:Number = 0;
		//最大上范围
		private var _maxDown:Number = 0;
		//最大下范围
		private var transverse:Boolean = false;
		//是否横向拖动
		private var longitudinal:Boolean = false;
		//是否纵向拖动
		private var dragTarget:Sprite;
		//目标MC
		private var onEnterFrame:Function;
		private var mouseError_x:Number = 0;
		//单击时鼠标相对于按钮的X误差
		private var mouseError_y:Number = 0;
		//单击时鼠标相对于按钮的Y误差
		private var _lockMouse:Boolean = true;
		//是否锁定鼠标位置
		private var x_Per:Number = 0;
		private var y_Per:Number = 0;
		private var _mouseStep:Number = 0.1;
		private var _mouseWheel:Boolean;
		private var _dragSignal:Signal;
		
		private var _dropSignal:Signal;
		public function DragMovie(mc:Sprite, maxleft:Number, maxright:Number, maxup:Number, maxdown:Number, _transverse:Boolean, _longitudinal:Boolean) {
			dragTarget = mc;
			maxLeft = maxleft;
			maxRight = maxright;
			maxUp = maxup;
			maxDown = maxdown;
			transverse = _transverse;
			longitudinal = _longitudinal;
			initDrag();
			_mouseWheel = false;
			_dragSignal = new Signal(Number, Number);
			_dropSignal = new Signal(Number);
		}
		private function initDrag():void
		{
			dragTarget.mouseChildren = false;
			dragTarget.buttonMode = true;
			dragTarget.addEventListener(MouseEvent.MOUSE_DOWN,_startDrag);
			//dragTarget.addEventListener(MouseEvent.MOUSE_UP,_stopDrag);
			//stage.addEventListener(MouseEvent.MOUSE_UP,_stopDrag);
			//dragTarget.addEventListener(MouseEvent.,_stopDrag);
		}
		public function set perX(n:Number):void
		{
			n = Math.max(Math.min(1,n),0);
			dragTarget.x = n*(maxRight-maxLeft)+maxLeft;
			x_Per = n;
			var event:DynamicEvent = new DynamicEvent("MOUSE_DRAG");
			event.obj.dragTarget = dragTarget;
			event.obj.x_per = x_Per;
			event.obj.y_per = y_Per;
			dispatchEvent(event);
			_dragSignal.dispatch(x_Per, y_Per);
		}
		public function get perX():Number{
			return x_Per;
		}
		public function set perY(n:Number):void
		{
			n = Math.max(Math.min(1,n),0);
			dragTarget.y = n*(maxDown-maxUp)+maxUp;
			y_Per = n;
			var event:DynamicEvent = new DynamicEvent("MOUSE_DRAG");
			event.obj.dragTarget = dragTarget;
			event.obj.x_per = x_Per;
			event.obj.y_per = y_Per;
			dispatchEvent(event);
			_dragSignal.dispatch(x_Per, y_Per);
		}
		public function get perY():Number{
			return y_Per;
		}
		private function _startDrag(e:Event):void
		{
			mouseError_x = _lockMouse ? dragTarget.mouseX*dragTarget.scaleX : 0;
			mouseError_y = _lockMouse ? dragTarget.mouseY*dragTarget.scaleY : 0;
			dragTarget.addEventListener(Event.ENTER_FRAME,enterFrame);
			dragTarget.stage.addEventListener(MouseEvent.MOUSE_UP,_stopDrag);
		}
		private function _stopDrag(e:Event):void
		{
			var event:DynamicEvent = new DynamicEvent("MOUSE_DRAG_STOP");
			event.obj.dragTarget = dragTarget;
			event.obj.x_per = x_Per;
			event.obj.y_per = y_Per;
			dispatchEvent(event);
			dragTarget.removeEventListener(Event.ENTER_FRAME,enterFrame);
			dragTarget.stage.removeEventListener(MouseEvent.MOUSE_UP,_stopDrag);
			_dropSignal.dispatch(x_Per,y_Per);
		}
		private function enterFrame(e:Event):void
		{
			var m_x:Number = dragTarget.parent.mouseX-mouseError_x;
			var m_y:Number = dragTarget.parent.mouseY-mouseError_y;
			if (transverse) {
				if (m_x<maxLeft) {
					dragTarget.x = maxLeft;
				} else if (m_x>maxRight) {
					dragTarget.x = maxRight;
				} else {
					dragTarget.x = m_x;
				}
				var x_per:Number = (dragTarget.x-maxLeft)/(maxRight-maxLeft);
			}
			if (longitudinal) {
				if (m_y<maxUp) {
					dragTarget.y = maxUp;
				} else if (m_y>maxDown) {
					dragTarget.y = maxDown;
				} else {
					dragTarget.y = m_y;
				}
				var y_per:Number = (dragTarget.y-maxUp)/(maxDown-maxUp);
			}
			x_Per = x_per;
			y_Per = y_per;
			var event:DynamicEvent = new DynamicEvent("MOUSE_DRAG");
			event.obj.dragTarget = dragTarget;
			event.obj.x_per = x_per;
			event.obj.y_per = y_per;
			dispatchEvent(event);
			_dragSignal.dispatch(x_per, y_per);
			//onDrag(x_per, y_per);
		}
		public function set mouseWhile(b:Boolean):void
		{
			trace("滚动支持")
			if (b) {
				//if (!_mouseWheel) {
					dragTarget.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				//}
			}else {
				//if (_mouseWheel) {
					dragTarget.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				//}
			}
			_mouseWheel = b;
		}
		
		public function get dragSignal():Signal 
		{
			return _dragSignal;
		}
		
		public function get mouseStep():Number 
		{
			return _mouseStep;
		}
		
		public function set mouseStep(value:Number):void 
		{
			_mouseStep = value;
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			var delta:int = e.delta;
			if(delta<0){
				if(transverse){
					perX = x_Per+_mouseStep;
				}
				if(longitudinal){
					perY = y_Per+_mouseStep;
				}
			}else{
				if(transverse){
					perX = x_Per-_mouseStep;
				}
				if(longitudinal){
					perY = y_Per-_mouseStep;
				}
			}
//			var event:DynamicEvent = new DynamicEvent("MOUSE_DRAG");
//			event.obj.dragTarget = dragTarget;
//			event.obj.x_per = perX;
//			event.obj.y_per = perY;
//			dispatchEvent(event);
//			_dragSignal.dispatch(perX, perY);
		}
		public function getXbyPercent(n:Number):Number {
			return n*(maxRight-maxLeft)+maxLeft;
		}
		public function getYbyPercent(n:Number):Number {
			return n*(maxDown-maxUp)+maxUp;
		}

		public function get dropSignal():Signal
		{
			return _dropSignal;
		}

		public function get maxUp():Number
		{
			return _maxUp;
		}

		public function set maxUp(value:Number):void
		{
			_maxUp = value;
		}

		public function get maxDown():Number
		{
			return _maxDown;
		}

		public function set maxDown(value:Number):void
		{
			_maxDown = value;
		}

		public function get maxLeft():Number
		{
			return _maxLeft;
		}

		public function set maxLeft(value:Number):void
		{
			_maxLeft = value;
		}

		public function get maxRight():Number
		{
			return _maxRight;
		}

		public function set maxRight(value:Number):void
		{
			_maxRight = value;
		}


	}
	
}