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
                
                HStack {
                    
                    if let price = midPrice {
                        
                        Text(midPrice ?? 0, format: .currency(code: "USD"))
                            .monospacedDigit()
                            .bold()
                        
                    }
                    
                }
                
            }
            .padding(20)
            
        }
        .fontDesign(.rounded)
        .background(Color.cloud)
        
    }
    
}

#Preview {
    
    OrderBookView(book: (try? OrderBook.sample()) ?? OrderBook())
    
}

