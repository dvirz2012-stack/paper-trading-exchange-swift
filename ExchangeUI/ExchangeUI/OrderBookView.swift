import SwiftUI
import ExchangeEngine

struct OrderBookView: View {
    
    let book: OrderBook
    
    var maxQuantity: Int {
        
        (book.sellersDepth + book.buyersDepth).map { $0.quantity }.max() ?? 1
        
    }
    
    var midPrice: Double? {
        
        if let bid = book.bestBid, let ask = book.bestAsk {
            
            return Double((ask + bid)) / 200
            
        }
        
        return nil
        
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Order Book")
                        .font(.largeTitle)
                        .bold()
                    Text("BWM / USD")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .bold()
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Mid Price")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.gray)
                    
                    HStack {
                        
                        if let price = midPrice {
                            
                            Text(midPrice ?? 0, format: .currency(code: "USD"))
                                .font(.largeTitle)
                                .monospacedDigit()
                                .bold()
                            
                        } else {
                            
                            Text("-")
                                .font(.largeTitle)
                                .monospacedDigit()
                                .bold()
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Text("Spread")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.gray)
                    
                    HStack {
                        
                        if let spread = book.spread {
                            
                            Text(Double(spread) / 100, format: .currency(code: "USD"))
                                .font(.largeTitle)
                                .monospacedDigit()
                                .bold()
                            
                        } else {
                            
                            Text("-")
                                .font(.largeTitle)
                                .monospacedDigit()
                                .bold()
                            
                        }
                        
                    }
                
                }
                .card()
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    HStack {
                        
                        Text("Price")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("Size")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.gray)
                    }
                    
                    .padding(.horizontal, 8)
                    
                    ForEach(book.sellersDepth.reversed(), id: \.price) { level in
                    
                        LevelRow(color: Color.softRed, level: level, maximum: maxQuantity)
                    
                    }
                    
                    Spacer()
                        .frame(height: 8)
                    
                    ForEach(book.buyersDepth, id: \.price) { level in
                        
                        LevelRow(color: Color.softGreen, level: level, maximum: maxQuantity)
                        
                    }
                    
                }
                
                .card()
                
            }
            .padding(20)
            
        }
        .fontDesign(.rounded)
        .background(Color.cloud)
        
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
            Text(Double(level.price) / 100, format: .number.precision(.fractionLength(2)))
                .foregroundStyle(color)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            Spacer()
            Text("\(level.quantity)")
                .foregroundStyle(.secondary)
                .fontDesign(.rounded)
        }
        .font(.subheadline)
        .monospacedDigit()
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(alignment: .trailing) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(color.opacity(0.12))
                    .frame(width: geo.size.width * fraction)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        
    }
    
}

#Preview {
    
    OrderBookView(book: (try? OrderBook.sample()) ?? OrderBook())
    
}

