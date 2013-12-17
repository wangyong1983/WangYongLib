package org.wang.website.vo.im20
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONEncoder;
	
	
	import org.wang.website.vo.BaseSendVO;
	
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ShareSiteVO extends BaseSendVO 
	{
		public static const RENREN:int = 1;
		public static const SINA:int = 2;
		public static const QQ:int = 3;
		public static const DOUBAN:int = 4;
		public static const KAIXIN:int = 5;
		public static const MSLIVE:int = 6;
		public static const NETEASE:int = 7;
//		6:, 7:网易微博
		private var openSNSID:String;
		public function ShareSiteVO() 
		{
			super();
			
			dataObj.shareId = 100002;
		}

		public function shareTo(n:int):ShareSiteVO
		{
			dataObj.shareTo = n;
			return this;
		}
		public function title(s:String):ShareSiteVO
		{
			dataObj.title = s;
			return this;
			
		}
		public function url(s:String):ShareSiteVO
		{
			dataObj.url = s;
			return this;
		}
		public function content(s:String):ShareSiteVO
		{
			dataObj.content = s;
			return this;
		}
		public function image(s:String):ShareSiteVO
		{
			dataObj.pic = s;
			return this;
		}
		public function friendList(s:String):ShareSiteVO
		{
			//dataObj.friendList = s;
			
			var arr:Array = s.split(" ");
			var len:int = arr.length;
			var dataArr:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (arr[i])
				{
					var obj:Object = new Object();
					obj.openSnsId = openSNSID;
					obj.account = arr[i];
					dataArr.push(obj);
				}
			}
			dataObj.friendList = new JSONEncoder(dataArr).getString();
			return this;
		}
		public function file(s:String):ShareSiteVO
		{
			dataObj.file = s;
			return this;
		}
		
		
		
	}

}