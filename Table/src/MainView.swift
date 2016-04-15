import Foundation

class MainView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStyle("Window #main{float:left;clear:left;}")
        container = addSubView(Container(1000,800,self,"main"))
        
        createTable()
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
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/table.xml")
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        node
        
        let table:Table = container.addSubView(Table(NaN,NaN,node,container))
        table
        //TableModifier.selectRow(table,1);
        
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
        
        //continue here: add TitleBar Icons css
        //Get rid of gradient in table 
        
        
    }
}