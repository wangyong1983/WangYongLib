package org.wang.website.vo.im20 
{
	import org.wang.website.vo.BaseResultVO;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class IM_ResultVO extends BaseResultVO 
	{
		
		public function IM_ResultVO(obj:Object) 
		{
			super(obj);
			
		}
		public function getData():Object
		{
			return data.data;
		}
		public function get errorCode():int
		{
			return int(data.errorcode);
		}
		public function get errordesc():String
		{
			return data.errordesc;
		}
	}

}