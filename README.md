# Paper Trading Exchange (Swift)

**A small stock exchange that runs on your Mac, with a real matching engine and fake money :)**

![Swift 6](https://img.shields.io/badge/Swift-6-orange?logo=swift)
![Platforms](https://img.shields.io/badge/platforms-macOS%2015%20%7C%20iOS%2018-blue)
![Tests](https://img.shields.io/badge/tests-33-brightgreen)

---

## What is this?

Ever wondered what actually happens when you press "Buy"? Someone has to find you a seller and agree on a price. That someone is a **matching engine**, and this repo is me building one from scratch in Swift.

The project has two parts:

| Part | What it does |
|---|---|
| **ExchangeEngine** | A Swift package with the order book, the matching logic, trades and candles. It does all the thinking. |
| **ExchangeUI** | A SwiftUI app that shows the book in a way humans can actually read. It's the part you look at :) |

No real money is involved at any point. You can't lose your savings here, only your pride.

---

## Features

### The engine

- **Limit orders**: "I want to buy 5 shares, but only at 100.00 or less."
- **Market orders**: "I want 5 shares right away, at whatever the current price is." Whatever can't be filled immediately gets cancelled, so a market order never sits in the book waiting.
- **Price-time priority**: the best price goes first, and if two orders share a price, whoever came first wins. Like a polite queue :)
- **Partial fills**: a big order can eat several small ones, and the leftover stays in the book.
- **Fair trade price**: a trade happens at the price of the order that was waiting in the book, not the one that just arrived.
- **Cancel orders** by ID, without touching trades that already happened.
- **Best bid, best ask and spread**, calculated live from the book.
- **Market depth**: orders grouped into price levels, ready to be drawn.
- **Candles (OHLCV)**: open, high, low, close and volume for any candle length you want, in seconds.
- **Input validation**: zero or negative quantities and prices throw clear errors instead of breaking things quietly.

### The app

- **Home**: a greeting that knows if it's morning or night, best bid and best ask cards, and a "Word Of The Day" to learn the trading vocabulary.
- **BookWorm**: the order book screen. *"Best at making you understand."* Sellers in red on top, buyers in green below, the spread in the middle, and depth bars that show how much is waiting at each price.

---

## How matching works (in 20 seconds)

The book keeps two lists:

- **Bids** (buyers): sorted from the highest price down
- **Asks** (sellers): sorted from the lowest price up

Every time a new order arrives, the engine checks one thing: **is the best buyer willing to pay at least what the best seller wants?** If yes, a trade happens and the matched quantity is removed from both orders. This repeats until the prices no longer cross.

```
Asks (sellers)     103.00 | 4
                   102.00 | 5
                   ------------  spread: 1.00
Bids (buyers)      101.00 | 4
                   100.00 | 5
```

Here nobody trades, because the best buyer (101.00) wants to pay less than the best seller (102.00). Send a buy order at 102.00 and a trade happens.

---

## Getting started

### Requirements

- macOS 15 or later (iOS 18 for the iPhone side)
- Xcode with a Swift 6.3 toolchain, since the package uses `swift-tools-version: 6.3` and Swift 6 language mode

### Build and test the engine

```bash
git clone https://github.com/dvirz2012-stack/paper-trading-exchange-swift.git
cd paper-trading-exchange-swift
swift build
swift test
```

If everything is green, congratulations, you now own a stock exchange. :)

### Use it in code

```swift
import ExchangeEngine

let book = OrderBook()

try book.addOrder(order: Order(side: .sell, quantity: 5, price: 10200))
try book.addOrder(order: Order(side: .buy, quantity: 3, price: 10200))

print(book.trades.count)          // 1
print(book.trades[0].price)       // 10200
print(book.asks[0].quantity)      // 2, the seller still has 2 left

// Market order: buy 2 at whatever the best price is
try book.addOrder(order: Order(side: .buy, quantity: 2, type: .market))

// One-minute candles
let candles = try book.calculateCandles(candleLength: 60)
```

> **Prices are in cents.** `10200` means `102.00`. Integers keep the math exact, because floating point and money are not friends.

### The app

The SwiftUI app lives in `ExchangeUI/` and uses the engine as a local package. Right now the Xcode project still points at paths on my own machine, so the easiest way to play with the exchange is through the engine and its tests. Making the app open anywhere is on the list. :)

---

## Tests

The engine has **33 tests** written with [Swift Testing](https://developer.apple.com/documentation/testing). The test names read like sentences, so the test list doubles as documentation:

- `one big order eats two small ones.`
- `price by who waited.`
- `market order against an empty book.`
- `cancelling doesn't delete trades from the past.`
- `three trades unite in the same minute.`

Run them with:

```bash
swift test
```

---

## Project structure

```
paper-trading-exchange-swift/
├── Package.swift
├── Sources/ExchangeEngine/
│   ├── Order.swift          # orders, sides, order types, validation
│   ├── OrderBook.swift      # the book, matching, cancel, depth, candles
│   ├── Trade.swift          # what happened, at what price, how much
│   ├── PriceLevel.swift     # one row of market depth
│   └── Candle.swift         # open, high, low, close, volume
├── Tests/ExchangeEngineTests/
│   └── OrderBookSwiftTesting.swift
└── ExchangeUI/              # the SwiftUI app
    └── ExchangeUI/
        ├── MyApp.swift
        ├── ContentView.swift
        ├── HomeView.swift
        └── OrderBookView.swift
```

---

## What's next

Ideas I'm working toward, not promises (yet):

- [ ] Place orders straight from the app instead of using demo data
- [ ] A live candlestick chart drawn from the engine's candles
- [ ] A real portfolio (the numbers on the Home screen are placeholders for now)
- [ ] The "Start learning" section
- [ ] A leaderboard, so you can prove you're the best fake trader in the room
- [ ] An Xcode project that opens on any machine

---

## About

Built by **Dvir** as a way to really understand how exchanges work, by building one instead of just reading about it.

If you found a bug, the engine probably has a test for it already. If it doesn't, open an issue and I'll add one. :)
