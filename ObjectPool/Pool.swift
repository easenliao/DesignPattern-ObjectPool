import Foundation

class Pool<T:AnyObject> {
    typealias ObjectRester = (T)->()
    private var data = [T]()
    private let array = DispatchQueue(label: "array")
    private let semaphore:DispatchSemaphore
    private let objectRester: ObjectRester
    init(items:[T], objectRester: @escaping  ObjectRester ) {
        self.objectRester = objectRester
        data.reserveCapacity(data.count)
        for item in items {
            data.append(item)
        }
        semaphore = DispatchSemaphore(value: items.count)
    }
    private func resetItem(item: T){
        objectRester(item)
    }
    func getFromPool() -> T? {
        var result:T?
        if semaphore.wait(timeout: .distantFuture) == .success {
            array.sync {
                result = self.data.remove(at: 0)
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        array.async {
            self.resetItem(item: item)
            self.data.append(item)
            self.semaphore.signal()
        }
    }
}
