//var folderURL = fl.browseForFolderURL("选择需要导出图片的文件目录")
var dom = fl.getDocumentDOM();
var library = dom.library;
function run()
{
	dom.backgroundColor = '#000000'
	var itemsList = library.getSelectedItems();
	var length = itemsList.length;
	var item;
	var elements;
	var url;
	var name;
	for(var i = 0; i < length; i+=1)
	{
		item = itemsList[i]
		//url = folderURL + "/" + itemsList[i].name + ".jpg";
		dom.addItem({x:0, y:0}, item);
		fl.trace(["length", dom.getTimeline().layers[0].frames[0].elements[0]]);
		
		var moveX = -dom.getTimeline().layers[0].frames[0].elements[0].left;
		var moveY = -dom.getTimeline().layers[0].frames[0].elements[0].top;
		
		var width = dom.getTimeline().layers[0].frames[0].elements[0].width;
		var height = dom.getTimeline().layers[0].frames[0].elements[0].height;
		
		fl.trace([width, height]);
		
		dom.getTimeline().layers[0].frames[0].elements[0].x += moveX;
		dom.getTimeline().layers[0].frames[0].elements[0].y += moveY;
		
		dom.width = Math.floor(width);
		dom.height =  Math.floor(height * 2);
		
		dom.addItem({x:0,y:height},item);
		
		dom.getTimeline().layers[0].frames[0].elements[1].x += moveX;
		dom.getTimeline().layers[0].frames[0].elements[1].y += moveY;
		
		dom.getTimeline().layers[0].frames[0].elements[1].selected = true;
		name = "mc_" + Math.floor(Math.random() * 9000) + 1000;
		element = dom.convertToSymbol("movie clip", name, "top left");
		
		element.selected = true;
		dom.setBlendMode("invert");
		
		return;
		
		/*library.deleteItem(name);
		
		dom.selectAll();
		dom.deleteSelection();
		dom.selectNone();*/
	}
}

run()