import ExchangeEngine

@available(macOS 15.0, *)
class OrderBookTests {
    
    func run() {
        
        let order1 = Order(side: Side.buy, quantity: 10000, price: 5)
        let order2 = Order(side: Side.buy, quantity: 10100, price: 3)
        let order3 = Order(side: Side.sell, quantity: 10200, price: 2)
        let order4 = Order(side: Side.buy, quantity: 10000, price: 1)
        let order5 = Order(side: Side.sell, quantity: 10150, price: 4)
        let order6 = Order(side: Side.sell, quantity: 10000, price: 6)
        let order7 = Order(side: Side.buy, quantity: 10200, price: 1)
        
        let book: OrderBook = OrderBook()
        
        book.addOrder(order: order1)
        book.addOrder(order: order2)
        book.addOrder(order: order3)
        book.addOrder(order: order4)
        book.addOrder(order: order5)
        book.addOrder(order: order6)
        book.addOrder(order: order7)
        
        print(book.bids)
        print(book.asks)
        print(book.trades)

        book.cancelOrder(id: order4.id)
        book.cancelOrder(id: order2.id)
        book.cancelOrder(id: order5.id)
        book.cancelOrder(id: order3.id)
        
        print(book.bids)
        print(book.asks)
        print(book.trades)
        
    }
    
}

