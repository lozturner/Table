import Foundation

class MainView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        createTable()
        container = addSubView(Container(1000,800,self,"main"))
    }
    /**
     *
     */
    func createTable(){
        let url:String = "~/Desktop/ElCapitan/advance/table/table.css"
        StyleManager.addStylesByURL(url,true)
        
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                StyleManager.addStylesByURL(url,true)
                ElementModifier.refreshSkin(self)
                ElementModifier.floatChildren(self)
            }
        }
        fileWatcher!.start()
        
        
        var card = addSubView(Card(NaN, NaN, "Table: ", self, "tableCard"))
        var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+"assets/xml/table.xml"));
        var database:Database = new Database(xml);
        var table:Table = tableSection.addChild(new Table(NaN,NaN,database,tableSection)) as Table;
        TableModifier.selectRow(table,1);
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
        
        
    }
}