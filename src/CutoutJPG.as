package
{
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.geom.Point;
import flash.geom.Rectangle;
/**
 * ...将jpg抠出转换为png
 * @author Kanon
 */
public class CutoutJPG
{
	/*左*/
	public static const LEFT:String = "left";
	/*右*/
	public static const RIGHT:String = "right";
	/*上*/
	public static const UP:String = "up";
	/*下*/
	public static const DOWN:String = "down";
	
	/**
	 * 将一个jpg的位图数据抠出转换为png数据
	 * @param	jpgBitmapData	一个jpg位图数据 是原始png的宽度的2倍并且将右半边填充为纯白色
	 * @param	copyDirection	拷贝通道的位置方向 朝左朝右，朝上朝下。
	 * @return	一个从原始jpg中抠取出实际颜色像素的png位图数据
	 */
	public static function cutout(jpgBitmapData:BitmapData, copyDirection:String):BitmapData
	{
		if (!jpgBitmapData) return null;
		var rectangle:Rectangle;
		var point:Point = new Point(0, 0);
		var width:Number = jpgBitmapData.width;
		var height:Number = jpgBitmapData.height;
		var x:Number = 0;
		var y:Number = 0;
		if (copyDirection == CutoutJPG.LEFT || copyDirection == CutoutJPG.RIGHT)
			width *= .5;
		else if (copyDirection == CutoutJPG.UP || copyDirection == CutoutJPG.DOWN)
			height *= .5;
		
		//创建一个jpgBitmapData宽度一半的位图数据
		var bitmapData:BitmapData = new BitmapData(width, height, true, 0xFFFFFF);
		
		//根据方向判断起始位置
		if (copyDirection == CutoutJPG.LEFT) x = bitmapData.width;
		if (copyDirection == CutoutJPG.UP) y = bitmapData.height;
		bitmapData.lock();
		//复制jpgBitmapData真实区域的像素到bitmapData中。
		rectangle = new Rectangle(x, y, bitmapData.width, bitmapData.height);
		bitmapData.copyPixels(jpgBitmapData, rectangle, point);
		
		//根据方向判断起始位置
		if (copyDirection == CutoutJPG.LEFT) x = 0;
		else if (copyDirection == CutoutJPG.RIGHT) x = bitmapData.width;
		if (copyDirection == CutoutJPG.UP) y = 0;
		else if (copyDirection == CutoutJPG.DOWN) y = bitmapData.height;
		
		//复制jpgBitmapData右半部分的红色通道
		rectangle = new Rectangle(x, y, bitmapData.width, bitmapData.height);
		bitmapData.copyChannel(jpgBitmapData, rectangle, point, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		bitmapData.unlock();
		//销毁原始位图数据
		jpgBitmapData.dispose();
		jpgBitmapData = null; 
		return bitmapData;
	}
	
	/**
	 * 根据一个纯白色的背景图片来裁剪图片
	 * @param	jpgBitmapData			一个需要裁剪的jpg位图数据
	 * @param	solidColorBitmapData	一个和原始图片高宽相同的纯白色位图数据
	 * @return	一个从原始jpg中抠取出实际颜色像素的png位图数据
	 */
	public static function cutoutFromSolidColorBitmapData(jpgBitmapData:BitmapData, solidColorBitmapData:BitmapData):BitmapData
	{
		if (!jpgBitmapData) return null;
		var rectangle:Rectangle;
		var point:Point = new Point(0, 0);
		//创建一个jpgBitmapData宽度相同的位图数据
		var bitmapData:BitmapData = new BitmapData(jpgBitmapData.width, jpgBitmapData.height, true, 0xFFFFFF);
		bitmapData.lock();
		
		//复制jpgBitmapData的像素到bitmapData中。
		rectangle = new Rectangle(0, 0, bitmapData.width, bitmapData.height);
		bitmapData.copyPixels(jpgBitmapData, rectangle, point);
		
		//复制solidColorBitmapData的红色通道
		bitmapData.copyChannel(solidColorBitmapData, rectangle, point, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		
		bitmapData.unlock();
		
		jpgBitmapData.dispose();
		solidColorBitmapData.dispose();
		
		jpgBitmapData = null; 
		solidColorBitmapData = null; 
		return bitmapData;
	}
}
}