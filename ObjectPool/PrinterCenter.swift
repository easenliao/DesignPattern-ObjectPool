import Foundation

class PrinterCenter {
    typealias CenterMachine = Printer
    private let pool: Pool<CenterMachine>
    static let shared = PrinterCenter(machineAmount:5)
    private init(machineAmount:Int) {
        var printers: [CenterMachine] = []
        for count in 1 ... machineAmount {
            printers.append(CenterMachine(printerID: "Machine-\(count)"))
        }
        pool = Pool<CenterMachine>(items: printers, objectRester: { item in
            item.text = ""
        })
    }
    func checkoutPrinter() -> CenterMachine? {
        let book = pool.getFromPool()
        return book
    }
    
    func returnPrinter(CenterMachine:CenterMachine) {
        pool.returnToPool(item: CenterMachine)
    }
    
}
