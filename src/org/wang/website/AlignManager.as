package org.wang.website 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 网蛹
	 * 
	 * 0.1版,仅限于场景对齐方式为 TL 的情况
	 */
	public class AlignManager 
	{
		private var _align:String;
		private var target:DisplayObjectContainer;
		private var _distance:Point;
		static private var _stage:Stage;
		static private var dictionary:Dictionary = new Dictionary(true);
		static public var CENTER:String = "MM";
		public function AlignManager(mc:DisplayObjectContainer, align:String = "TL", p:Point = null) 
		{
			target = mc;
			_align = align;
			if (p == null)
			{
				distance = new Point();
			}else
			{
				distance = p;
			}
			ResizeManager.getInstance().resizeSignal.add(onResize);
			dictionary[target] = this;
			onResize(ResizeManager.getInstance().stageWidth, ResizeManager.getInstance().stageHeight);
		}
		public function remove():void
		{
			dictionary[target] = null;
			ResizeManager.getInstance().resizeSignal.remove(onResize);
		}
		private function onResize(width:Number,height:Number):void 
		{
			switch(_align)
			{
				case StageAlign.TOP:
					target.x = width / 2 + distance.x;
					target.y = distance.y;
					break;
				case StageAlign.TOP_LEFT:
					target.x = distance.x;
					target.y = distance.y;
					break;
				case StageAlign.TOP_RIGHT:
					target.x = width + distance.x;
					target.y = distance.y;
					break;
				case StageAlign.BOTTOM:
					target.x = width / 2 + distance.x;
					target.y = height + distance.y;
					break;
				case StageAlign.BOTTOM_LEFT:
					target.x = distance.x;
					target.y = height + distance.y;
					break;
				case StageAlign.BOTTOM_RIGHT:
					target.x = width + distance.x;
					target.y = height + distance.y;
					break;
				case CENTER:
					target.x = width / 2 + distance.x;
					target.y = height / 2 + distance.y;
					break;
				case StageAlign.LEFT:
					target.x = distance.x;
					target.y = height / 2 + distance.y;
					break;
				case StageAlign.RIGHT:
					target.x = width + distance.x;
					target.y = height / 2 + distance.y;
					break;
			}
		}
		public static function add(mc:DisplayObjectContainer, align:String = "TL", p:Point = null):AlignManager
		{
			if (dictionary[mc])
			{
				AlignManager(dictionary[mc]).remove();
			}
			
			return new AlignManager(mc, align, p);
		}
		public static function remove(mc:DisplayObjectContainer):void
		{
			if (dictionary[mc])
			{
				AlignManager(dictionary[mc]).remove();
			}
		}
		public function get align():String 
		{
			return _align;
		}
		
		public function set align(value:String):void 
		{
			_align = value;
		}
		
		static public function get stage():Stage 
		{
			return _stage;
		}
		
		static public function set stage(value:Stage):void 
		{
			_stage = value;
		}
		
		public function get distance():Point 
		{
			return _distance;
		}
		
		public function set distance(value:Point):void 
		{
			_distance = value;
		}
		
	}

}