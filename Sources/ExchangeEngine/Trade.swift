
public class Trade {
    
    public let buyOrderId: Int
    public let sellOrderId: Int
    public let price: Int
    public let quantity: Int
    
    public init (buyOrderId: Int, sellOrderId: Int, price: Int, quantity: Int) {
        
        self.buyOrderId = buyOrderId
        self.sellOrderId = sellOrderId
        self.price = price
        self.quantity = quantity
        
    }
    
}

