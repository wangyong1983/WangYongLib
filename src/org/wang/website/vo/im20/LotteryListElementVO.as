package org.wang.website.vo.im20
{
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class LotteryListElementVO extends IM_ResultVO 
	{
		
		public function LotteryListElementVO(obj:Object) 
		{
			super(obj);
			
		}
		public function get userID():String
		{
			return data.uid;
		}
		public function get headImage():String
		{
			return data.tinyUrl;
		}
		public function get mobile():String
		{
			return data.profile.mobile;
		}
		public function get nickName():String
		{
			return data.account;
		}
		public function get lotteryID():String
		{
			return String(data.lotteryId);
		}
		public function get lotteryName():String
		{
			return data.lotteryName;
		}
		public function get lotteryTime():String
		{
			return data.createTime;
		}
		
	}

}