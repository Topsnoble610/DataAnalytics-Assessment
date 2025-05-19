-- Assessment_Q2
-- Transaction Frequency Analysis

-- Checking the two tables
Select * From users_customuser;
Select * From savings_savingsaccount;

-- 
-- Calculating the average number of transactions per customer per month
-- Categorizing average number of transactions per month
Select
    Case
        When monthly_average_transaction >= 10 Then 'high frequency'
        When monthly_average_transaction Between 3 And 9 Then 'medium frequency'
        Else 'low frequency'
    End As frequency_category,
    -- Counting customers transactions
    Count(*) As customer_count,
    -- Rounding the monthly average transaction to one decimal place
    Round(Avg(monthly_average_transaction), 1) As avg_transactions_per_month
From (
    -- Getting monthly average transactions for each customer
    Select 
        ssa.owner_id,
        count(*) / Timestampdiff(Month, min(ssa.transaction_date), max(ssa.transaction_date)) As monthly_average_transaction
    From savings_savingsaccount As ssa
    Group By ssa.owner_id
) As transaction_stats
Group By frequency_category;



