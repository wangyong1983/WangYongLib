package org.wang.common 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author leo.wang
	 */
	public class PageManager 
	{
		private var _currPage:int;
		private var _totalPage:int;
		private var _numPerPage:int;
		private var _hasprevPage:Boolean;
		private var _hasnextPage:Boolean;
		private var _pageChangeSignal:Signal;
		private var _flipSignal:Signal;
		public function PageManager() 
		{
			_pageChangeSignal = new Signal();
			_flipSignal = new Signal(int);
		}
		
		public function get currPage():int 
		{
			return _currPage;
		}
		
		public function set currPage(value:int):void 
		{
			_currPage = value;
			checkPage();
		}
		
		private function checkPage():void 
		{
			if (_currPage == 0)
			{
				_hasprevPage = false;
			}else
			{
				_hasprevPage = true;
			}
			if (_currPage == totalPage-1)
			{
				_hasnextPage = false;
			}else
			{
				_hasnextPage = true;
			}
			pageChangeSignal.dispatch();
		}
		
		public function get totalPage():int 
		{
			return _totalPage;
		}
		
		public function set totalPage(value:int):void 
		{
			_totalPage = value;
			checkPage();
		}
		
		public function get numPerPage():int 
		{
			return _numPerPage;
		}
		
		public function set numPerPage(value:int):void 
		{
			_numPerPage = value;
		}
		
		public function get hasprevPage():Boolean 
		{
			return _hasprevPage;
		}
		
		public function get hasnextPage():Boolean 
		{
			return _hasnextPage;
		}
		
		public function get pageChangeSignal():Signal 
		{
			return _pageChangeSignal;
		}
		
		public function get flipSignal():Signal 
		{
			return _flipSignal;
		}
		public function nextPage():void
		{
			if (_currPage < _totalPage-1)
			{
				_currPage++;
				_flipSignal.dispatch(_currPage);
			}
			checkPage();
		}
		public function prevPage():void
		{
			if (_currPage > 0)
			{
				_currPage--;
				_flipSignal.dispatch(_currPage);
			}
			checkPage();
		}
	}

}