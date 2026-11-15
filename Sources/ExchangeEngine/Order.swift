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

public enum OrderType {
    
    case market
    case limit
    
}

@available(macOS 15.0, *)
public class Order {
    
        private static let nextId = Atomic<Int>(1)
        public var id: Int
        public let side: Side
        public var quantity: Int
        public let price: Int
        public var timestamp: Date
        public let type: OrderType
    
    
    public init (side: Side, quantity: Int, price: Int = 0, type: OrderType = OrderType.limit) throws {
        
            self.side = side
            self.type = type
            if (quantity <= 0){
                
                throw OrderErrors.quantityError
                
            }
            self.quantity = quantity
            if (price <= 0 && type == OrderType.limit){
                
                throw OrderErrors.priceError
                
            }
            if (type == OrderType.limit){
                
                self.price = price

            } else {
                
                if (side == Side.buy){
                    
                    self.price = Int.max
                    
                } else {
                    
                    self.price = 1
                    
                }
                
            }
            self.timestamp = Date.now
            self.id = Order.nextId.add(1, ordering: .relaxed).oldValue
         
    }
}
