import Foundation

class MainView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStyle("Window #main{float:left;clear:left;padding-left:12px;padding-top:12px;}")
        container = addSubView(Container(1000,800,self,"main"))
        
        //createTable()
        
        testSorting()
    }
    /**
     *
     */
    func testSorting(){
        
        
        let eva = Human(firstName: "Eddie", lastName: "Van Halen" )
        let jp = Human(firstName:"Jimmy", lastName: "Page")
        let jh = Human(firstName:"Jimi", lastName: "Hendrix")
        let sv = Human(firstName:"Steve", lastName: "Vai")
        var guitarists = [eva, jp,jh, sv]
        
        sort(&guitarists)//& is address of operator to use the adress of the value not the value it self
        sort(&guitarists) {$0.firstName < $1.firstName}//comparable protocol
        guitarists.reverse()
        var sortedGuitarists = sorted(guitarists)
        sorted(&guitarists) {$0.firstName < $1.firstName}//comparable protocol
        

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
        
        let table:Table = container.addSubView(Table(190,120,node,container))
        table
        //TableModifier.selectRow(table,1);
        
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
        
        
        
    }
}