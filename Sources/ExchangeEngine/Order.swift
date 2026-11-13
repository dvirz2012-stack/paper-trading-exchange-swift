import Foundation
import Synchronization

public enum Side: String {
    
    case buy
    case sell
    
}

public enum OrderErrors: Error {
    
    case priceError
    case quantityError
    
}

@available(macOS 15.0, *)
public class Order {
    
        private static let nextId = Atomic<Int>(1)
        public var id: Int
        public let side: Side
        public var quantity: Int
        public let price: Int
        public var timestamp: Date
    
    
        public init (side: Side, quantity: Int, price: Int) throws {
        
            self.side = side
            if (quantity <= 0){
                
                throw OrderErrors.quantityError
                
            }
            self.quantity = quantity
            if (price <= 0){
                
                throw OrderErrors.priceError
                
            }
            self.price = price
            self.timestamp = Date.now
            self.id = Order.nextId.add(1, ordering: .relaxed).oldValue
         
    }
}
