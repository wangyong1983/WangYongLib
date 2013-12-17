package org.wang.website.vo.im20
{
	import org.wang.website.vo.im20.IM_ResultVO;
	
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class LotteryListResultVO extends IM_ResultVO 
	{
		private var _length:int;
		private var dataArr:Array;
		public function LotteryListResultVO(obj:Object) 
		{
			super(obj);
			_length = 0;
			if (!getData())
			{
				return;
			}
			if(getData().data == null)
				{
					return ;
				}
			_length = getData().data.length;
			dataArr = [];
			for (var i:int = 0; i < _length; i++) 
			{
				dataArr.push(new LotteryListElementVO(getData().data[i]));
			}
//			trace("---------------------")
//			trace(getData().page);
//			trace(getData().pageCount);
//			trace(page);
//			trace(pageCount);
		}
		public function getLotteryByID(n:int):LotteryListElementVO
		{
			return dataArr[n] as LotteryListElementVO;
		}
		public function get lotteryList():Array
		{
			return dataArr;
		}
		public function get page():int
		{
			return int(getData().page);
		}
		public function get pageCount():int
		{
			return int(getData().pageCount);
		}
		
		public function get length():int 
		{
			return _length;
		}
		public function totalCount():int
		{
			return getData().totalCount;
		}
		public function every(f:Function):void
		{
			dataArr.every(f);
		}
	}

}