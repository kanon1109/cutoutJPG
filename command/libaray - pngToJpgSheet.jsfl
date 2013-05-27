var dom = fl.getDocumentDOM();
var library = dom.library;

function run()
{
	var itemsList = library.getSelectedItems();
	var length = itemsList.length;
	var item;
	for(var i = 0; i < length; i+=1)
	{
		fl.trace(i)
		item = dom.addItem({x:0,y:0},itemsList[i]);
		dom.width = item.width;
		dom.height = item.height * 2;
		item.x = -item.left;
		item.y = -item.top;
		
		item = dom.addItem({x:0,y:0},itemsList[i]);
		item.x = -item.left;
		item.y = -item.top + item.height;
		
		
		
		
	}
}

run()