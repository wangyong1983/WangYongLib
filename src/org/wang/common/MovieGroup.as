package org.wang.common 
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author leo.wang
	 */
	public class MovieGroup 
	{
		private var currMovie:DisplayObjectContainer;
		private var container:DisplayObjectContainer;
		private var list:Vector.<DisplayObject>;
		private var baseName:String;
		private var curr:int;
		private var total:int;
		private var showFunc:Function;
		private var hideFunc:Function;
		public function MovieGroup(parent:DisplayObjectContainer,name:String,num:int,current:int = 0) 
		{
			container = parent;
			baseName = name;
			curr = current;
			showFunction = baseShowFunc;
			hideFunction = baseHideFunc;
			init(num);
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
//		public function getMovie(n:int):DisplayObjectContainer
//		{
//			return 
//		}
		public function showNext():void
		{
			//curr++;
			var next:int = curr + 1;
			
			next = next % total;
			//trace(curr);
			show(next);
		}
		public function showPrev():void
		{
			var next:int = curr - 1;
			next = (next + total) % total;
			//trace(curr);
			show(next);
		}
		public function getChildByIndex(n:int):DisplayObject
		{
			return list[n];
		}
		protected function baseShowFunc(mc:DisplayObject):void
		{
			mc.visible = true;
		}
		protected function baseHideFunc(mc:DisplayObject):void
		{
			mc.visible = false;
		}
		protected function baseAlphaHideFunc(mc:DisplayObject):void
		{
			TweenLite.to(mc,0.5,{autoAlpha:0});
		}
		protected function baseAlphaShowFunc(mc:DisplayObject):void
		{
			TweenLite.to(mc,0.5,{autoAlpha:1});
		}
		public function autoAlphaFunc():void
		{
			showFunc = baseAlphaShowFunc;
			hideFunc = baseAlphaHideFunc;
		}
		public function set showFunction(f:Function):void
		{
			showFunc = f;
		}
		public function set hideFunction(f:Function):void
		{
			hideFunc = f;
		}
		private function init(num:int):void 
		{
			list = new Vector.<DisplayObject>;
			total = num;
			for (var i:int = 0; i < num; i++) 
			{
				list[i] = container.getChildByName(baseName + i);
				list[i].visible = false;
			}
			show(curr);
		}
		public function hideAll():void
		{
			for (var i:int = 0; i < total; i++) 
			{
				hideFunc(list[i]);
				curr = -1;
			}
		}
		public function show(n:int,autoHide:Boolean = true):DisplayObject
		{
			
			if (n < list.length && n >=0)
			{
				if (autoHide)
				{
					hide(curr);
				}
				curr = n;
				showFunc(list[n]);
				return list[n];
			}else
			{
				return null;
			}
		}
		public function hide(n:int):DisplayObject
		{
			if (n < list.length && n >=0)
			{
				hideFunc(list[n]);
				return list[n];
			}else
			{
				return null;
			}
		}
		public function get currentShow():int
		{
			return curr;
		}
	}

}