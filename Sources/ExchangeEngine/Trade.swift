import Foundation
import Synchronization

public class Trade {
    
    public let buyOrderId: Int
    public let sellOrderId: Int
    public let price: Int
    public let quantity: Int
    public let timestamp: Date
    
    public init (buyOrderId: Int, sellOrderId: Int, price: Int, quantity: Int, timestamp: Date = Date.now) {
        
        self.buyOrderId = buyOrderId
        self.sellOrderId = sellOrderId
        self.price = price
        self.quantity = quantity
        self.timestamp = timestamp
        
    }
    
}

