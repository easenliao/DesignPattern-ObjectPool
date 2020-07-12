
protocol PrinterProtocol {
    var printerID:String { get }
    func printOut(text:String)
}

struct Printer:PrinterProtocol {
    let printerID:String
    func printOut(text: String) {
        print("Printer-\(printerID)--\(text)")
    }
}
