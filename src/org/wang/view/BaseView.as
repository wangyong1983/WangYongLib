package org.wang.view 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import org.wang.core.ArrayIterator;
	import org.wang.interfaces.IIterator;
	import org.wang.interfaces.IView;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseView implements IView 
	{
		private var _view:DisplayObjectContainer;
		//private var _parent:IView;
		//private var childs:Dictionary;
		private var _name:String;
		private static var _childs:Dictionary = new Dictionary();
		public function BaseView(v:DisplayObjectContainer) 
		{
			_view = v;
			_name = v.name;
			_childs[_name] = this;
			//childs = new Dictionary();
		}
		public function initMovieClip(arr:Array, arr2:Array,autoStop:Boolean = false):void
		{
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				var mc:MovieClip = arr[i] as MovieClip;
				mc = getChildMovieByName(arr2[i]);
				//arr[i] = mc;
				//trace(arr[i])
				if (autoStop)
				{
					MovieClip(arr[i]).gotoAndStop(1);
				}
			}
		}
		public static function getViewByName(s:String):IView
		{
			return _childs[s];
		}
		
		/*如果你继承之后有监听,重写此方法并在里面把所有监听注销掉*/
		public function destory(b:Boolean = false,remove:Boolean = false):void
		{
			if (b)
			{
				if (remove && _view.parent)
				{
					_view.parent.removeChild(view);
					
				}
				
			}
			_view = null;
			_childs[_name] = null;
		}
		/*
		public function addChild(v:IView):IView
		{
			childs[v.name] = v;
			v.parent = this;
			return this;
		}*/
		public function clearView():void
		{
			while (_view.numChildren)
			{
				_view.removeChildAt(0);
			}
		}
		public function childIterator():IIterator
		{
			var arr:Array = [];
			for (var i:int = 0; i < numChildren; i++) 
			{
				if (getViewChildrenByDepth(i))
				{
					arr.push(getViewChildrenByDepth(i));
				}
			}
			return new ArrayIterator(arr);
		}
		public function spriteChildIterator():IIterator
		{
			var arr:Array = [];
			for (var i:int = 0; i < numChildren; i++) 
			{
				if (getChildSpriteByDepth(i))
				{
					arr.push(getChildSpriteByDepth(i));
				}
			}
			return new ArrayIterator(arr) as IIterator;
		}
		public function movieChildIterator():IIterator
		{
			var arr:Array = [];
			for (var i:int = 0; i < numChildren; i++) 
			{
				if (getChildMovieByDepth(i))
				{
					arr.push(getChildMovieByDepth(i));
				}
			}
			return new ArrayIterator(arr);
		}
		public function getViewChildrenByName(s:String):DisplayObject
		{
			return _view.getChildByName(s);
		}
		public function getViewChildrenByDepth(n:int):DisplayObject
		{
			return _view.getChildAt(n);
		}
		public function get numChildren():int
		{
			return _view.numChildren;
		}
		public function getChildSpriteByName(s:String):Sprite
		{
			return getViewChildrenByName(s) as Sprite;
		}
		public function getChildSpriteByDepth(n:int):Sprite
		{
			return getViewChildrenByDepth(n) as Sprite;
		}
		public function getChildMovieByName(s:String):MovieClip
		{
			return getViewChildrenByName(s) as MovieClip;
		}
		public function getChildMovieByDepth(n:int):MovieClip
		{
			return getViewChildrenByDepth(n) as MovieClip;
		}
		public function getChildTextFieldByName(s:String):TextField
		{
			return getViewChildrenByName(s) as TextField;
		}
		public function getChildTextFieldByDepth(n:int):TextField
		{
			return getViewChildrenByDepth(n) as TextField;
		}
		public function getChildBitmapByName(s:String):Bitmap
		{
			return getViewChildrenByName(s) as Bitmap;
		}
		public function getChildBitmapByDepth(n:int):Bitmap
		{
			return getViewChildrenByDepth(n) as Bitmap;
		}
		public function get viewMovieClip():MovieClip
		{
			return _view as MovieClip;
		}
		public function get viewSprite():Sprite
		{
			return _view as Sprite;
		}
		/* INTERFACE org.wang.interfaces.IView */
		public function get view():DisplayObjectContainer 
		{
			return _view;
		}
		/*
		public function get parent():IView 
		{
			return _parent;
		}
		public function set parent(v:IView):void
		{
			_parent = v;
		}
		*/
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}

}