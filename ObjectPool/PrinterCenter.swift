import Foundation

class PrinterCenter {
    private let pool: Pool<PrinterProtocol>;
    static let shared = PrinterCenter(machineAmount:5);
    private init(machineAmount:Int) {
        var printers: [PrinterProtocol] = []
        for count in 1 ... machineAmount {
            printers.append(Printer(printerID: "Machine-\(count)"))
        }
        pool = Pool<PrinterProtocol>(items:printers);
    }
    func checkoutPrinter() -> PrinterProtocol? {
        let book = pool.getFromPool();
        return book;
    }
    
    func returnPrinter(printer:PrinterProtocol) {
        pool.returnToPool(item: printer);
    }
    
}
