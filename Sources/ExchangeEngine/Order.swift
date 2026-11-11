import Synchronization
import Foundation

public enum Side: String {
    
    case buy
    case sell
    
}


@available(macOS 15.0, *)
public class Order {
    
    private static let nextId = Atomic<Int>(1)
    public var id: Int
    public var side: Side
    public let quantity: Int
    public let price: Int
    public let timestamp: Date
    
    public init (side: Side, price: Int, quantity: Int) {
        
        self.id = Order.nextId.add(1, ordering: .relaxed).oldValue
        self.side = side
        self.quantity = quantity
        self.price = price
        self.timestamp = Date.now
        
    }
    
}

