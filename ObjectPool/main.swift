import Foundation

var queue = DispatchQueue(label: "work",attributes: .concurrent)
var group = DispatchGroup()

print("Starting...")

for _ in 1 ... 20 {
    queue.async(group: group){() in
        let printer = PrinterCenter.shared.checkoutPrinter()
        if let printer = printer {
            sleep(UInt32(Int.random(in: 1...5)))
            printer.typeIn(text: "Test Text")
            printer.printOut()
            PrinterCenter.shared.returnPrinter(CenterMachine: printer)
        }
    }
}
let _ = group.wait(timeout: .distantFuture)

print("All blocks complete")

