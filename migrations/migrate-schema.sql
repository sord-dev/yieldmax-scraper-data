CREATE TABLE IF NOT EXISTS ticker ( -- This table stores ETF metadata (from the ETF webpage)
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    isin TEXT NOT NULL,
    net_asset_value TEXT NOT NULL,
    shares_outstanding INTEGER NOT NULL,
    listings_and_codes TEXT DEFAULT NULL,
    distribution_history TEXT DEFAULT NULL,
    variations TEXT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS instrument ( -- This table stores instrument metadata for each ETF variation (from Trading212)
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticker_id INTEGER NOT NULL,
    instrument_ticker TEXT NOT NULL, -- This is the ticker used in Trading212
    isin TEXT NOT NULL,
    name TEXT NOT NULL,
    short_name TEXT NOT NULL,
    currency TEXT NOT NULL,
    FOREIGN KEY (ticker_id) REFERENCES ticker(id)
);

CREATE TABLE IF NOT EXISTS position ( -- This table stores user positions in ETFs, including estimated payout (calculated from current_price and ticker distribution_history)
    -- This table is used to track user positions in ETFs, including the quantity and average price
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticker_id INTEGER NOT NULL,
    instrument_id INTEGER NOT NULL,
    instrument_ticker TEXT NOT NULL, 
    quantity REAL NOT NULL,
    estimated_payout REAL DEFAULT NULL, -- This is the estimated payout for the position
    average_price REAL NOT NULL,
    current_price REAL NOT NULL,
    FOREIGN KEY (ticker_id) REFERENCES ticker(id),
    FOREIGN KEY (instrument_id) REFERENCES instrument(id)
);
