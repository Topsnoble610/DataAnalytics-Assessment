-- Assessment_Q1
-- High-Value Customers with Multiple Products

-- To identify relationsip keys
Select * From users_customuser;
Select * From savings_savingsaccount;
Select * From plans_plan;

-- Merging the tables together
-- Inserting the conditions inside the merged tables
Select pp.owner_id,
	   concat(uc.last_name,' ',uc.first_name) As name, 
	   count(Distinct ssa.savings_id) As savings_count,
	   count(Distinct pp.id) As investment_count, 
	   sum(ssa.amount) As total_deposits
From users_customuser As uc
Inner Join savings_savingsaccount As ssa
On uc.id = ssa.owner_id
Inner Join plans_plan As pp
On uc.id = pp.owner_id
-- Applying the conditions by filtering
Where ssa.amount > 0 And pp.amount > 0
Group By uc.id, concat(uc.last_name,' ',uc.first_name)
Having (count(Distinct ssa.savings_id)) >=1 And count(Distinct pp.id) >=1
Order by total_deposits Desc;




