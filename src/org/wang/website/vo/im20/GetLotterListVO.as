package org.wang.website.vo.im20
{
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class GetLotterListVO extends IM_SendVO 
	{
		
		public function GetLotterListVO() 
		{
			super();
			dataObj.lotteryType = "LotteryOne";
//			dataObj.lotteryId = ;
		}
		public function nickName(s:String):GetLotterListVO
		{
			dataObj.nick = s;
			return this;
		}
		public function lotteryId(n:String):GetLotterListVO
		{
			dataObj.lotteryId = n;
			return this;
		}
		public function page(n:int):GetLotterListVO
		{
			dataObj.page = n;
			return this;
		}
		public function limit(n:int):GetLotterListVO
		{
			dataObj.limit = n;
			return this;
		}
	}

}