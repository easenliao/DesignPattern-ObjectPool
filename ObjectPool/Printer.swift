
class Printer {
    let printerID:String
    var text: String = ""
    init(printerID: String){
        self.printerID = printerID
    }
    func typeIn(text:String){
        self.text += text
    }
    func printOut() {
        print("Printer-\(printerID)--\(text)")
    }

}
