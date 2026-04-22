# Betax

mix backtest --strategy Arbitrage --limit 10


betax/
├── lib/
│   ├── mix/tasks/
│   │   └── backtest.ex      # El comando que disparas
│   ├── betax/
│   │   ├── engine.ex        # Orquestador (el que hace el stream de ticks)
│   │   ├── simulator.ex     # ExchangeSimulator (GenServer de matching)
│   │   └── strategy.ex      # El Behaviour (la "interfaz")
│   └── strategies/
│       ├── penny_jumping.ex # Tu estrategia específica
│       └── arbitrage.ex
├── data/                    # Donde guardas tus .db de 5 mins
└── mix.exs
