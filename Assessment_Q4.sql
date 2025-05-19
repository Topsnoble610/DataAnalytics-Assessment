-- Assessment_Q4
-- Customer Lifetime Value (CLV) Estimation

-- checking the tables
Select * From users_customuser;
Select * From savings_savingsaccount;

-- Fetching the output
Select uc.id As customer_id,
	   Concat(last_name,' ',first_name) As name,
       Timestampdiff(Month, enabled_at, Curdate()) As tenure_months,
       Count(savings_id) As total_transactions,
       Round((Count(savings_id)/(Timestampdiff(Month, enabled_at, Curdate())))*12*(Avg(0.001 * amount)),2) As estimated_clv
From users_customuser As uc
Inner Join savings_savingsaccount
On uc.id = owner_id
Where enabled_at Is Not Null
Group By uc.id, name
Order By estimated_clv Desc;
       
	
       
       