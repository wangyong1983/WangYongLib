package org.wang.mouse 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class MouseDrager 
	{
		private var _distanceSignal:Signal
		private var _accelerationSignal:Signal;
		private var _dragingSignal:Signal;
		private var _distance:Number;
		private var _acceleration:Number;
		private var startPoint:Point;
		private var lastDistancePoint:Point;
		private var lastPoint:Point;
		private var target:DisplayObjectContainer;
		private var _type:String;
		private var currPoint:Point;
		private var distanceNum:int;
		private var autoCheck:Boolean;
		private var _dragEventSignal:Signal;
		
		public function MouseDrager() 
		{
			_distance = 10;
			_acceleration = 5;
			_type = "x";
			startPoint = new Point();
			_distanceSignal = new Signal(int,int);
			_accelerationSignal = new Signal(Number);
			_dragingSignal = new Signal(Point, Point);
			_dragEventSignal = new Signal(Boolean);
		}
		
		public function attach(mc:DisplayObjectContainer, auto:Boolean = true ):void
		{
			trace("add:",mc);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDoneEvent);
			target = mc;
			autoCheck = auto;
			if (auto)
			{
				autoListener();
			}
		}
		
		private function autoListener():void 
		{
			target.addEventListener(Event.ADDED_TO_STAGE, onAddLis);
			target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveLis);
			
		}
		
		private function onRemoveLis(e:Event):void 
		{
			//removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveLis);
			trace("mouse drager remove");
			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDoneEvent);
			target.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
			target.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpEvent);
		}
		
		private function onAddLis(e:Event):void 
		{
			//removeEventListener(Event.ADDED_TO_STAGE, onAddLis);
			trace("readd");
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDoneEvent);
		}
		public function remove(mc:DisplayObjectContainer):void
		{
			target.removeEventListener(Event.ADDED_TO_STAGE, onAddLis);
			target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveLis);
			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDoneEvent);
		}
		private function onMouseDoneEvent(e:MouseEvent):void 
		{
			
			startPoint.x = target.stage.mouseX;
			startPoint.y = target.stage.mouseY;
			lastDistancePoint = startPoint.clone();
			currPoint = startPoint.clone();
			distanceNum = 0;
			_dragEventSignal.dispatch(true);
			trace("start:" + startPoint);
			target.addEventListener(Event.ENTER_FRAME, onEnterCheck);
			target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpEvent, false, 0, true);
		}
		
		private function onEnterCheck(e:Event):void 
		{
			currPoint.x = target.stage.mouseX;
			currPoint.y = target.stage.mouseY;
			_dragingSignal.dispatch(startPoint, currPoint);
			//trace(currPoint,lastDistancePoint);
			
			var disX:Number = currPoint.x - lastDistancePoint.x;
			var disY:Number = currPoint.y - lastDistancePoint.y;
			var direct:int;
			switch(_type)
			{
				case "x":
					if (Math.abs(disX) >= _distance)
					{
						
						if (disX > 0)
						{
							distanceNum++;
							direct = 1;
						}else
						{
							distanceNum--;
							direct = 0;
						}
						lastDistancePoint = currPoint.clone();
						trace("check:" + lastDistancePoint);
						_distanceSignal.dispatch(distanceNum,direct);
					}
					break;
				case "y":
					if (Math.abs(disY) >= _distance)
					{
						if (disY > 0)
						{
							distanceNum++;
							direct = 1;
						}else
						{
							distanceNum--;
							direct = 0;
						}
						lastDistancePoint = currPoint.clone();
						distanceNum++;
						_distanceSignal.dispatch(distanceNum,direct);
					}
					break;
			}
			lastPoint = currPoint.clone();
		}
		
		private function onMouseUpEvent(e:MouseEvent):void 
		{
			//检查加速度
			target.removeEventListener(Event.ENTER_FRAME, onEnterCheck);
			target.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpEvent);
			currPoint.x = target.stage.mouseX;
			currPoint.y = target.stage.mouseY;
			//trace("松开:");
			_dragEventSignal.dispatch(false);
			switch(_type)
			{
				case "x":
					if (Math.abs(currPoint.x - lastPoint.x) >= _distance)
					{
						_accelerationSignal.dispatch(currPoint.x - lastPoint.x);
					}
					break;
				case "y":
					if (Math.abs(currPoint.y - lastPoint.y) >= _distance)
					{
						_accelerationSignal.dispatch(currPoint.x - lastPoint.x);
					}
					break;
			}
		}
		public function get distanceSignal():Signal 
		{
			return _distanceSignal;
		}
		
		public function get distance():Number 
		{
			return _distance;
		}
		
		public function set distance(value:Number):void 
		{
			_distance = value;
		}
		
		public function get acceleration():Number 
		{
			return _acceleration;
		}
		
		public function set acceleration(value:Number):void 
		{
			_acceleration = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get accelerationSignal():Signal 
		{
			return _accelerationSignal;
		}
		
		public function get dragingSignal():Signal 
		{
			return _dragingSignal;
		}
		
		public function get dragEventSignal():Signal 
		{
			return _dragEventSignal;
		}
		
	}

}