@available(macOS 15.0, *)
public class OrderBook {
    
    public var bids: [Order] = []
    public var asks: [Order] = []
    public var trades: [Trade] = []
    
    public func addOrder(order: Order) {
        
        switch(order.side) {
            
            case Side.buy:
                self.bids.append(order)
                self.bids.sort { a, b in
                    if a.price == b.price {
                    
                        return a.id < b.id
                    
                    }
                
                    return a.price > b.price
                
                }
            
            case Side.sell:
                self.asks.append(order)
                self.asks.sort {a, b in
            
                    if a.price == b.price {
                    
                        return a.id > b.id
                    
                    }
                
                    return a.price < b.price
                
                }
        }
        
    }
    
    public func match() {
        
        while (self.bids.count != 0 && self.asks.count != 0 && self.bids[0].price >= self.asks[0].price) {
            
            let orderToRemove: Int = min(self.bids[0].quantity, self.asks[0].quantity)
            let trade: Trade = Trade(buyOrderId: self.bids[0].id, sellOrderId: self.asks[0].id, price: self.bids[0].id < self.asks[0].id ? self.bids[0].price : self.asks[0].price, quantity: orderToRemove)
            self.trades.append(trade)
            
            if (self.bids[0].quantity == 0) {
                
                self.bids.remove(at: 0)
                
            }
            
            if (self.asks[0].quantity == 0) {
                
                self.asks.remove(at: 0)
                
            }
            
        }
        
    }
    
    public func cancelOrder(id: Int) -> Bool {
        
        for (idx, sellOrder) in self.asks.enumerated() {
            
            if (sellOrder.id == id) {
                
                self.asks.remove(at: idx)
                return true
                
            }
            
        }
        
        for (idx, buyOrder) in self.bids.enumerated() {
            
            if (buyOrder.id == id) {
                
                self.bids.remove(at: idx)
                return true
                
            }
            
        }
        
        return false
        
    }
    
}
