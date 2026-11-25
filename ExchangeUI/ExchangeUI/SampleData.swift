import SwiftUI
import ExchangeEngine

extension OrderBook {
    
    static func sample() throws -> OrderBook {
        
        let book = OrderBook()
        
        let buyOrders: [Order] = [
            
            try Order(side: Side.buy, quantity: 3, price: 9700, type: OrderType.limit),
            try Order(side: Side.buy, quantity: 21, price: 9800, type: OrderType.limit),
            try Order(side: Side.buy, quantity: 7, price: 9900, type: OrderType.limit),
            try Order(side: Side.buy, quantity: 15, price: 10000, type: OrderType.limit)
        
        ]
        
        let sellOrders: [Order] = [
        
            try Order(side: Side.sell, quantity: 10, price: 10100, type: OrderType.limit),
            try Order(side: Side.sell, quantity: 13, price: 10200, type: OrderType.limit),
            try Order(side: Side.sell, quantity: 7, price: 10300, type: OrderType.limit),
            try Order(side: Side.sell, quantity: 20, price: 10400, type: OrderType.limit)

            
        ]
            
        for order in buyOrders {
            
            book.addOrder(order: order)
            
        }
        
        for order in sellOrders {
         
            book.addOrder(order: order)
            
        }
        
        return book
        
    }
    
}

