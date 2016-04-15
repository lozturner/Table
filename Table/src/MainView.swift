import Foundation


class Human {
    let firstName: String
    let lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class MainView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        
        
        StyleManager.addStyle("Window #main{float:left;clear:left;padding-left:12px;padding-top:12px;}")
        container = addSubView(Container(1000,800,self,"main"))
        
        createTable()
        

    }
    
    /**
     *
     */
    func createTable(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer/card.css")
        
        
        
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
        
        let table:Table = container.addSubView(Table(190,120,node,container))
        
        TableModifier.selectRow(table,1);
        
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
        
        
        
    }
}