package  
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
/**
 * ...抠图例子
 * @author Kanon
 */
public class CutoutJPGSample extends Sprite 
{
	private var bmd:BitmapData;
	public function CutoutJPGSample() 
	{
		this.bmd = new Image();
		var bitmapData:BitmapData = CutoutJPG.cutout(this.bmd, CutoutJPG.DOWN);
		var bitmap:Bitmap = new Bitmap(bitmapData, "auto", true);
		this.addChild(bitmap);
	}
	
}
}