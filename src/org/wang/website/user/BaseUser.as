package org.wang.website.user 
{
	import org.wang.core.BaseVO;
	import org.wang.interfaces.IUser;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class BaseUser extends BaseVO implements IUser
	{
		private var _name:String;
		private var _sex:int;
		private var _phoneNumber:String;
		private var _mail:String;
		public function BaseUser() 
		{
			super();
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get sex():int 
		{
			return _sex;
		}
		
		public function set sex(value:int):void 
		{
			_sex = value;
		}
		
		public function get phoneNumber():String 
		{
			return _phoneNumber;
		}
		
		public function set phoneNumber(value:String):void 
		{
			_phoneNumber = value;
		}
		
		public function get mail():String 
		{
			return _mail;
		}
		
		public function set mail(value:String):void 
		{
			_mail = value;
		}
		
		
	}

}