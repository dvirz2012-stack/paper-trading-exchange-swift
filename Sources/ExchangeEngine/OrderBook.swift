import Foundation
import Synchronization

public enum CandleErrors: Error {
    
    case candleLengthZero
    case candleLengthNegative
    
}

@available(macOS 15.0, *)

public class OrderBook {
    
    public var bids: [Order] = []
    public var asks: [Order] = []
    public var trades: [Trade] = []
    
    public var bestBid: Int? {
        
        return self.bids.first?.price
        
    }
    
    public var bestAsk: Int? {
        
        return self.asks.first?.price
        
    }
    
    public var spread: Int? {
        
        if let bestAskInSpread = bestAsk, let bestBidInSpread = bestBid {
            
            return bestAskInSpread - bestBidInSpread
            
        }
        
        return nil
        
    }
    
    public var buyersDepth: [PriceLevel] {
        
        return self.createDepth(orders: bids)
        
    }
    
    public var sellersDepth: [PriceLevel] {
        
        return self.createDepth(orders: asks)
        
    }
    
    public init () {
        
        
        
    }
    
    public func addOrder(order: Order) {
    
        switch (order.side) {
            
            case Side.buy:
                self.bids.append(order)
                self.bids.sort { a, b in
                
                    if ( b.price == a.price ) {
                    
                        return b.id > a.id
                    
                    }
                
                    return a.price > b.price
                }
            
            case Side.sell:
                self.asks.append(order)
                self.asks.sort { a, b in
            
                    if (b.price == a.price) {
                    
                        return a.id < b.id
                    
                    }
                
                    return a.price < b.price
                
                }
            
        }
        
        self.match()
        
        if (order.type == OrderType.market && order.quantity != 0){
            
            self.cancelOrder(id: order.id)
            
        }
        
    }
    
    public func match() {
        
        while (self.bids.count != 0 && self.asks.count != 0 && self.bids[0].price >= self.asks[0].price) {
            
            let orderToRemove: Int = min(self.bids[0].quantity, self.asks[0].quantity)
            
            let trade: Trade = Trade(buyOrderId: self.bids[0].id, sellOrderId: self.asks[0].id, price: self.bids[0].id < self.asks[0].id ? self.bids[0].price : self.asks[0].price, quantity: orderToRemove)
            
            self.trades.append(trade)
            
            self.bids[0].quantity -= orderToRemove
            self.asks[0].quantity -= orderToRemove
            
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
    
    public func calculateCandles(candleLength: Int) throws -> [Candle] {
        
        if (candleLength == 0) {
            
            throw CandleErrors.candleLengthZero
            
        }
        
        if (candleLength < 0) {
            
            throw CandleErrors.candleLengthNegative
            
        }
        
        var candles: [Candle] = []
        
        for trade in trades {
            
            let seconds: Double = trade.timestamp.timeIntervalSince1970
            let intSecs: Int = Int(seconds) / candleLength * candleLength
            if let lastCandle = candles.last, lastCandle.seconds == intSecs {
                
                candles[candles.count - 1].high = (lastCandle.high > trade.price) ? lastCandle.high : trade.price
                
                candles[candles.count - 1].low = (lastCandle.low < trade.price) ? lastCandle.low : trade.price
                
                candles[candles.count - 1].close = trade.price
                
                candles[candles.count - 1].volume += trade.quantity
                
                    
            } else {
                
                candles.append(Candle(high: trade.price, low: trade.price, close: trade.price, volume: trade.quantity, seconds: intSecs, open: trade.price))
                
            }
            
        }
        
        return candles
        
    }
    
    private func createDepth(orders: [Order]) -> [PriceLevel] {
        
        var depths: [PriceLevel] = []
        
        for order in orders {
            
            if let lastLevel = depths.last, lastLevel.price == order.price {
                
                depths[depths.count - 1].quantity += order.quantity
                depths[depths.count - 1].timesPriceShown += 1
                
            } else {
                
                depths.append(PriceLevel(price: order.price, quantity: order.quantity, timesPriceShown: 1))
                
            }
                        
        }
        
        return depths
        
    }
    
}
