-- Assessment_Q3
-- Account Inactivity Alert

-- Checking the two tables
Select * From plans_plan;
Select * From savings_savingsaccount;

-- Finding all active accounts with no transactions in the 1 year(365 days)
Select id As plan_id,
	   owner_id,
       'investment' As type,
       max(last_charge_date) As last_transaction_date,
       datediff(curdate(), max(last_charge_date)) As inactivity_days
From plans_plan 
Where last_charge_date Is Not Null And is_a_fund = 1 And is_regular_savings = 1
Group By id, owner_id

-- Appending investment from plans_plan table and savings from savings_savingsaccount table
Union

Select savings_id As plan_id,
	   owner_id,
       'Savings' As type,
       max(transaction_date) As last_transaction_date,
       datediff(curdate(),max(transaction_date)) As inactivity_days
From savings_savingsaccount 
Where transaction_date Is Not Null 
Group By savings_id, owner_id
Having inactivity_days > 365;

       
       
       
       
       
       
       
       
