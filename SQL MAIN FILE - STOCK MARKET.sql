use stock_market;
show tables;

-- KPI 1 --
Select concat(round(SUM(share_price * outstanding_shares)/1000000,0), "M") as Total_Market_Capatilization 
From stocks;

-- KPI 2 --
select AVG(avg_vol) AS Avg_daily_trading_volume
FROM fact_daily_prices;

-- KPI 3 --
Select concat(round(stddev(daily_return)*100,2) , "%") as Volatility from fact_daily_prices;

-- KPI 4 --
select sector, AVG(return_pct) AS avg_return
FROM stocks
GROUP BY sector
ORDER BY avg_return DESC
LIMIT 1;

-- KPI 5 --
select SUM(quantity * current_price) AS portfolio_value
FROM stocks;

-- KPI 6 --
select ((SUM(current_value) - SUM(initial_value)) / SUM(initial_value)) * 100 AS portfolio_return_pct
FROM stocks;

-- KPI 7 --
select s.ticker, (SUM(d.dividend_per_share) / s.share_price) * 100 AS dividend_yield_pct
FROM fact_dividends d
INNER JOIN dim_company dc
ON d.company_id = dc.company_id
INNER JOIN stocks s
ON s.company_name=dc.company_name
GROUP BY s.ticker, s.share_price;

-- KPI 8 --
select (AVG(return_pct) - 0.02) / STDDEV(return_pct) AS sharpe_ratio
FROM stocks;

--  KPI 9 --
Select concat(round(count(Trader_id) / count(order_id) * 100,0), "%") as Order_Execution_Rate from fact_orders;

-- KPI 10 --
select SUM(win_flag) * 1.0 / COUNT(*) AS trade_win_rate
FROM fact_trades_pnl_kpi;

--  KPI 11 --
select trader_id, SUM(gross_sell_amount - gross_buy_amount - total_fees_allocated) AS trader_pnl
FROM fact_trades_pnl_kpi
GROUP BY trader_id
Limit 1;







