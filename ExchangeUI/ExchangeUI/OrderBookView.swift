import SwiftUI
import ExchangeEngine

struct OrderBookView: View {
    
    let book: OrderBook = (try? runEngine()) ?? OrderBook()
    var maxQuantity: Int {
        
        (book.buyersDepth + book.sellersDepth).map { $0.quantity}.max() ?? 1
        
    }
    
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
        
        TabView {
            
            Tab("Order Book", systemImage: "clock") {
                VStack(spacing: 12) {
                    Text("BookWorm")
                        .font(.largeTitle)
                        .bold()
                    Text("Best at making you understand.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Price")
                            .foregroundStyle(.gray)
                            .bold()
                        Spacer()
                        Text("Size")
                            .foregroundStyle(.gray)
                            .bold()
                        
                    }
                    
                    ForEach(book.sellersDepth.reversed(), id: \.price) { level in
                        
                        LevelRow(color: .red, level: level, maximum: maxQuantity)
                        
                    }
                    Divider()
                    if let spread = book.spread {
                        
                        Text("Spread: \(Double(spread) / 100, format: .number.precision(.fractionLength(2)))")
                            .foregroundStyle(.gray)
                        
                    } else {
                        
                        Text("Spread: -")
                        
                    }
                    Divider()
                    
                    ForEach(book.buyersDepth, id: \.price) { level in
                        
                        LevelRow(color: .green, level: level, maximum: maxQuantity)
                        
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .frame(minWidth: 300, minHeight: 200)
            }
        }
            
    }
}

struct LevelRow: View {
    
    let color: Color
    let level: PriceLevel
    let maximum: Int
    var fraction: Double {
        
        Double(level.quantity) / Double(maximum)
        
    }
    
    var body: some View {
        
        HStack {
            
            Text("\(Double(level.price) / 100, format: .number.precision(.fractionLength(2)))")
            Spacer()
            Text("\(level.quantity)")
            
        }
        .foregroundStyle(color)
        .monospacedDigit()
        .background {
            
            GeometryReader { geo in
                
                Rectangle()
                    .fill(color.opacity(0.15))
                    .frame(width: geo.size.width * fraction)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
        }
    }
    
}

#Preview {
    ContentView()
}

