/**
* ...
* @author 网蛹
* @version 0.1
*/

package org.wang.movie{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.wang.event.MovieEvent;
	public class MovieControler extends EventDispatcher{
		private var con_target:MovieClip;
		private var listening:Boolean;
		private var targetFrame:uint;
		private static var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function get _target():MovieClip{
			return con_target;
		}
		public static function get _dispatcher():EventDispatcher{
			return dispatcher;
		}
		public static function getControler(mc:MovieClip):MovieControler{
			if(mc.Controler){
			}else{
				mc.Controler = new MovieControler(mc);
			}
			return mc.Controler;
		}
		public static function PlayToHead(mc:MovieClip):void
		{
			if(mc.Controler){
				mc.Controler.playToFrame(1);
			}else{
				mc.Controler = new MovieControler(mc);
				mc.Controler.playToFrame(1);
			}
		}
		public static function PlayToBottom(mc:MovieClip):void
		{
			if(mc.Controler){
				mc.Controler.playToFrame(mc.totalFrames);
			}else{
				mc.Controler = new MovieControler(mc);
				mc.Controler.playToFrame(mc.totalFrames);
			}
		}
		public static function PlayToFrame(mc:MovieClip,frame:uint):void
		{
			if(mc.Controler){
				mc.Controler.playToFrame(frame);
			}else{
				mc.Controler = new MovieControler(mc);
				mc.Controler.playToFrame(frame);
			}
		}
		public static function JumpToFrame(mc:MovieClip,frame:uint):void
		{
			if(mc.Controler){
				mc.gotoAndStop(frame);
				mc.Controler.playToFrame(frame);
			}else{
				mc.Controler = new MovieControler(mc);
				mc.gotoAndStop(frame);
				mc.Controler.playToFrame(frame);
			}
		}
		public static function PlayToLabel(mc:MovieClip,lab:String):void
		{
			var arr:Array = mc.currentLabels;
			for(var i:String in arr){
				if(arr[i].name == lab){
					MovieControler.PlayToFrame(mc,arr[i].frame);
					return;
				}
			}
			try{
				throw new Error("Not found label: "+lab);
			}catch (err:Error){
				trace(err.message)
			}
			return;
		}
		
		public function MovieControler(obj:MovieClip = null) {
			super();
			try{
				if(obj){
					con_target = obj;
				}else{
					throw new Error("Need a target");
				}
			}catch (err:Error){
				trace(err.message);
			}
			con_target.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			listening = false;
			targetFrame = 1;
		}
		private function onRemove(e:Event):void
		{
			con_target.removeEventListener(Event.ENTER_FRAME,playtoframe);
		}
		public function playToHead():void
		{
			playToFrame(1);
		}
		public function playToBottom():void
		{
			playToFrame(con_target.totalFrames);
		}
		public function jumpToFrame(n:uint):void
		{
			con_target.gotoAndStop(n);
			if(listening){
				targetFrame = n;
			}else{
				targetFrame = n;
				listening = true;
				con_target.addEventListener(Event.ENTER_FRAME,playtoframe);
			}
		}
		public function playToFrame(n:uint):void
		{
			if(listening){
				targetFrame = n;
			}else{
				targetFrame = n;
				listening = true;
				con_target.addEventListener(Event.ENTER_FRAME,playtoframe);
			}
		}
		private function playtoframe(evt:Event):void
		{
			var me:MovieEvent = new MovieEvent(MovieEvent.PLAY_PROGRESS);
			me.mc_Target = con_target;
			MovieControler.dispatcher.dispatchEvent(me);
			if(evt.target.currentFrame > targetFrame){
				evt.target.prevFrame();
			}else if(evt.target.currentFrame < targetFrame){
				evt.target.nextFrame();
			}else{
				listening = false;
				evt.target.removeEventListener(Event.ENTER_FRAME,playtoframe);
				var me_2:MovieEvent = new MovieEvent(Event.COMPLETE);
				me_2.mc_Target = con_target;
				MovieControler.dispatcher.dispatchEvent(me_2);
				dispatchEvent(me_2);
			}
		}
		
	}
}