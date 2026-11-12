import Testing
import ExchangeEngine

@available(macOS 15.0, *)

@Test func `buy order entering to buyers.`() async throws {
    
    let order: Order = try Order(side: Side.buy, quantity: 1000, price: 2)
    let book: OrderBook = OrderBook()
    book.addOrder(order: order)
    
    #expect(book.bids.count == 1)
    #expect(book.asks.count == +0)
    
}

@available(macOS 15.0, *)

@Test func `buy orders sorted from highest to lowest.`() async throws {
    
    let book: OrderBook = OrderBook()
    let order1: Order = try Order(side: Side.buy, quantity: 5, price: 10000)
    let order2: Order = try Order(side: Side.buy, quantity: 3, price: 10200)
    let order3: Order = try Order(side: Side.buy, quantity: 2, price: 10100)
    
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
    
    let order1: Order = try Order(side: Side.buy, quantity: 5, price: 10000)
    let order2: Order = try Order(side: Side.buy, quantity: 3, price: 10000)
    let order3: Order = try Order(side: Side.buy, quantity: 2, price: 10000)
    
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
    
    let order1: Order = try Order(side: Side.sell, quantity: 5, price: 10000)
    let order2: Order = try Order(side: Side.sell, quantity: 3, price: 10200)
    let order3: Order = try Order(side: Side.sell, quantity: 2, price: 10100)
    
    book.addOrder(order: order1)
    book.addOrder(order: order2)
    book.addOrder(order: order3)
    
    #expect(book.asks[0].id == order1.id)
    #expect(book.asks[1].id == order3.id)
    #expect(book.asks[2].id == order2.id)
    
}

@available(macOS 15.0, *)

@Test func `no trade if the buyer offers less than the seller.`() async throws {
    
    let book: OrderBook = OrderBook()
    let buyOrder: Order = try Order(side: Side.buy, quantity: 3, price: 10000)
    let sellOrder: Order = try Order(side: Side.sell, quantity: 5, price: 10100)
    
    book.addOrder(order: buyOrder)
    book.addOrder(order: sellOrder)
    
    #expect(book.trades.count == 0)
    
}

@available(macOS 15.0, *)

@Test func `one trade, both lists are empty.`() async throws {
    
    let book: OrderBook = OrderBook()
    let buyOrder: Order = try Order(side: Side.buy, quantity: 5, price: 10100)
    let sellOrder: Order = try Order(side: Side.sell, quantity: 5, price: 10000)
    
    book.addOrder(order: buyOrder)
    book.addOrder(order: sellOrder)
    
    #expect(book.bids.count == 0)
    #expect(book.asks.count == 0)
    
}

@available(macOS 15.0, *)

@Test func `the bigger side in the trade has a surplus, still in the book.`() async throws {
    
    let book: OrderBook = OrderBook()
    let buyOrder: Order = try Order(side: Side.buy, quantity: 6, price: 10100)
    let sellOrder: Order = try Order(side: Side.sell, quantity: 5, price: 10000)
    
    book.addOrder(order: buyOrder)
    book.addOrder(order: sellOrder)
    
    #expect(book.bids[0].quantity == 1)
    
}

@available(macOS 15.0, *)

@Test func `one big order eating two small ones.`() async throws {
    
    let book: OrderBook = OrderBook()
    let bigSellOrder: Order = try Order(side: Side.sell, quantity: 10, price: 9000)
    let smallBuyOrder1: Order = try Order(side: Side.buy, quantity: 3, price: 10000)
    let smallBuyOrder2: Order = try Order(side: Side.buy, quantity: 2, price: 10000)
    
    book.addOrder(order: bigSellOrder)
    book.addOrder(order: smallBuyOrder1)
    book.addOrder(order: smallBuyOrder2)
    
    #expect(book.trades.count == 2)
    
}

@available(macOS 15.0, *)

@Test func `price by who waited.`() async throws {
    
    let book: OrderBook = OrderBook()
    let sellOrder: Order = try Order(side: Side.sell, quantity: 5, price: 10150)
    let buyOrder: Order = try Order(side: Side.buy, quantity: 4, price: 10200)
    
    book.addOrder(order: sellOrder)
    book.addOrder(order: buyOrder)
    
    #expect(book.trades[0].price == 10150)
    
}
