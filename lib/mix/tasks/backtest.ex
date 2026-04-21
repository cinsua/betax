defmodule Mix.Tasks.Backtest do
  use Mix.Task

  @shortdoc "Corre el backtesting sobre archivos DB con límite opcional"

  def run(args) do
    # 1. Parsear argumentos
    # Agregamos 'limit: :integer' para que Elixir lo convierta automáticamente
    {opts, _, _} =
      OptionParser.parse(args, switches: [strategy: :string, limit: :integer, coin: :string])

    # 2. Configuración y Valores por defecto
    strategy_name = opts[:strategy] || "MyPennyJumpingStrategy"
    coin = opts[:coin] || "btc"
    # :all funcionará como bandera para no limitar
    limit = opts[:limit] || :all

    # strategy_module = Module.concat([Hassian.Strategies, strategy_name])

    # 3. Obtener archivos y aplicar el filtro
    db_files =
      (Path.wildcard("./db/#{coin}/*/*.db") ++
         Path.wildcard("./db/#{coin}/*/*.db.gz"))
      |> sort_files()
      |> apply_limit(limit)

    # 4. Ejecución
    if Enum.empty?(db_files) do
      IO.puts(:stderr, "No se encontraron archivos .db en ./data/")
    else
      IO.puts("Estrategia: #{strategy_name} - #{coin}")
      IO.puts("Archivos a procesar: #{length(db_files)}")

      # Ejecutamos cada mercado
      Enum.each(db_files, fn file ->
        IO.puts("\n>>> Procesando: #{Path.basename(file)}")
        # Hassian.Engine.run(strategy_module, file)
      end)
    end
  end

  # Funciones privadas de ayuda para limpiar el flujo
  defp apply_limit(files, :all), do: files
  defp apply_limit(files, n), do: Enum.take(files, n)

  # Orden alfabético/temporal básico
  defp sort_files(files), do: Enum.sort(files)
end
