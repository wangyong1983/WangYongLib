package org.wang.utils 
{
	/**
	 * ...
	 * @author leo.wang
	 */
	public class ColorTools 
	{
		
		public function ColorTools() 
		{
			/*
			red = color24 >> 16;
			green = color24 >> 8 & 0xFF;
			blue = color24 & 0xFF;
			alpha = color32 >> 24;
			red = color32 >> 16 & 0xFF;
			green = color32 >> 8 & 0xFF;
			blue = color232 & 0xFF;*/
		}
		public static function getRed32(color32:uint):uint
		{
			return color32 >>> 16 & 0xFF;
		}
		public static function getGreen32(color32:uint):uint
		{
			return color32 >>> 8 & 0xFF;
		}
		public static function getBlur32(color32:uint):uint
		{
			return color32 & 0xFF;
		}
		public static function getAlpha32(color32:uint):uint
		{
			return color32 >>> 24;
		}
		
		public static function getRed(color24:uint):uint
		{
			return color24 >> 16;
		}
		public static function getGreen(color24:uint):uint
		{
			return color24 >> 8 & 0xFF;
		}
		public static function getBlur(color24:uint):uint
		{
			return color24 & 0xFF;
		}
	}

}