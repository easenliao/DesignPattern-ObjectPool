import Foundation

class Pool<T> {
    private var data = [T]();
    private let array = DispatchQueue(label: "array")
    private let semaphore:DispatchSemaphore
    
    init(items:[T]) {
        data.reserveCapacity(data.count);
        for item in items {
            data.append(item);
        }
        semaphore = DispatchSemaphore(value: items.count)
    }
    
    func getFromPool() -> T? {
        var result:T?;
        if semaphore.wait(timeout: .distantFuture) == .success {
            array.sync {
                result = self.data.remove(at: 0)
            }
        }
        return result;
    }
    
    func returnToPool(item:T) {
        array.async {
            self.data.append(item);
            self.semaphore.signal()
        }
    }
}
