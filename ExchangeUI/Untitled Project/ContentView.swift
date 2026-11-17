import SwiftUI
import ExchangeEngine

struct ContentView: View {
    
    let book: OrderBook = (try? runEngine()) ?? OrderBook()
    
    static func runEngine() throws -> OrderBook {
        
        let book: OrderBook = OrderBook()
        let buyOrder1: Order = try Order(side: Side.buy, quantity: 5, price: 10000, type: OrderType.limit)
        let buyOrder2: Order = try Order(side: Side.buy, quantity: 4, price: 10100, type: OrderType.limit)
        let sellOrder1: Order = try Order(side: Side.sell, quantity: 5, price: 10200, type: OrderType.limit)
        let sellOrder2: Order = try Order(side: Side.sell, quantity: 4, price: 10300, type: OrderType.limit)
        
        book.addOrder(order: buyOrder1)
        book.addOrder(order: buyOrder2)
        book.addOrder(order: sellOrder1)
        book.addOrder(order: sellOrder2)
       
        return book
    }
    
    
    var body: some View {
        
        VStack(spacing: 12) {
            Text("Order Book")
                .font(.title)
            if let bid = book.bestBid {
                
                Text("Best bid: \(bid)")
                    .foregroundStyle(.green)
                
            } else {
                
                Text("Best bid: -")
                
            }
            
            if let ask = book.bestAsk {
                
                Text("Best ask: \(ask)")
                    .foregroundStyle(.red)
                
            } else {
                
                Text("Best ask: -")
                
            }
            
            ForEach(book.sellersDepth.reversed(), id: \.price) { level in
                
                HStack {
                    
                    Text(" \(level.price)")
                        .foregroundStyle(.red)
                    Spacer()
                    Text("\(level.quantity)")
                        .foregroundStyle(.red)
                    
                }
                
            }
            
            if let spread = book.spread {
                
                Text("Spread: \(spread)")
                
            } else {
                
                Text("Spread: -")
                
            }
            
            ForEach(book.buyersDepth, id: \.price) { level in
            
                HStack {
                    
                    Text("\(level.price)")
                        .foregroundStyle(.green)
                    Spacer()
                    Text("\(level.quantity)")
                        .foregroundStyle(.green)
                }
                
            }
            
        }
        .padding()
        .frame(minWidth: 300, minHeight: 200)
        
    }
}

#Preview {
    ContentView()
}
