import Testing
import ExchangeEngine

@available(macOS 15.0, *)

@Test func `buy order entering to buyers.`() async throws {
    
    let order: Order = Order(side: Side.buy, quantity: 1000, price: 2)
    let book: OrderBook = OrderBook()
    book.addOrder(order: order)
    
    #expect(book.bids.count == +0)
    #expect(book.asks.count == 1)
    
}

@available(macOS 15.0, *)

@Test func `buy orders sorted from highest to lowest.`() async throws {
    
    let book: OrderBook = OrderBook()
    let order1: Order = Order(side: Side.buy, quantity: 5, price: 10000)
    let order2: Order = Order(side: Side.buy, quantity: 3, price: 10200)
    let order3: Order = Order(side: Side.buy, quantity: 2, price: 10100)
    
    book.addOrder(order: order1)
    book.addOrder(order: order2)
    book.addOrder(order: order3)
    
    #expect(book.bids[0].id == order2.id)
    #expect(book.bids[1].id == order3.id)
    #expect(book.bids[2].id == order1.id)
    
}

@available(macOS 15.0, *)

@Test func `same price on 3 buy orders.`() async throws {
    
    let book: OrderBook = OrderBook()
    
    let order1: Order = Order(side: Side.buy, quantity: 5, price: 10000)
    let order2: Order = Order(side: Side.buy, quantity: 3, price: 10000)
    let order3: Order = Order(side: Side.buy, quantity: 2, price: 10000)
    
    book.addOrder(order: order1)
    book.addOrder(order: order2)
    book.addOrder(order: order3)
    
    #expect(book.bids[0].id == order1.id)
    #expect(book.bids[1].id == order2.id)
    #expect(book.bids[2].id == order3.id)
    
}

@available(macOS 15.0, *)

@Test func `sell orders sorted from high to low.`() async throws {
    
    let book: OrderBook = OrderBook()
    
    let order1: Order = Order(side: Side.sell, quantity: 5, price: 10000)
    let order2: Order = Order(side: Side.sell, quantity: 3, price: 10200)
    let order3: Order = Order(side: Side.sell, quantity: 2, price: 10100)
    
    book.addOrder(order: order1)
    book.addOrder(order: order2)
    book.addOrder(order: order3)
    
    #expect(book.asks[0].id == order1.id)
    #expect(book.asks[1].id == order3.id)
    #expect(book.asks[2].id == order2.id)
    
}
