# DataAnalytics-Assessment
1. Assessment_Q1 - High-Value Customers with Multiple Products
•	The first thing I did was to identify the relationships between the three tables: users_customuser, savings_savingsaccount, and plans_plan.
•	So I discovered that there is owner_id in both savings_savingsaccount and plans_plan, which links to the id column in users_customuser. This owner_id acts like a bridge connecting a customer to their accounts.
•	Knowing this, I used Inner joins to merge the tables together so I could work with them in a single query.
•	I renamed each table for simplicity:
users_customuser as uc,
savings_savingsaccount as ssa,
plans_plan as pp.
•	I filtered the results to include only customers who had at least one savings record and one investment plan with actual money in them (amount > 0).
•	I grouped everything by customer, counted how many savings and investment plans they had, and summed up all their deposits.
•	Finally, I sorted the list by total deposit amount so high-value customers would appear at the top.
________________________________________
2. Assessment_Q2 - Transaction Frequency Analysis
•	First, I wanted to understand how often customers make transactions.
•	I focused on the savings_savingsaccount table since it records transactions.
•	For each customer, I counted how many total transactions they had.
•	Then I calculated how long they've been active by checking the number of months between their first and last transaction.
•	To get the average number of transactions per month, I simply divided the total transactions by that number of months.
•	After getting this monthly average per customer, I grouped them into categories:
	“High Frequency” if they do 10 or more transactions a month
	“Medium Frequency” if they fall between 3 and 9
	“Low Frequency” if they do 2 or fewer
•	Lastly, I counted how many customers fall into each category and calculated the average number of transactions per category.
________________________________________
3. Assessment_Q3 - Account Inactivity Alert
•	The goal here was to find accounts that haven’t had any activity in over a year.
•	I fetched id from plans_plan and savings_id from savings_savingsaccount and named both as plan_id
•	Also added owner_id to the list of columns in the expected output
•	I added a new column ‘type’ to contain investment or savings. Investment for plans_plan table and savings for savings_savingsaccount table
•	I checked both plans_plan and savings_savingsaccount because savings and investment accounts can both become inactive.
•	For investment accounts, I looked at the last_charge_date field in plans_plan, which I named as last_transaction_date as stated in the expected output.
•	For savings, I used the transaction_date from savings_savingsaccount, which I also named as last_transaction_date as stated in the expected output.
•	I used MAX() to find the latest transaction date for each account.
•	Then I compared that date to today using DATEDIFF() to calculate how many days have passed since the last transaction.
•	I filtered the last_charge_date and transaction_date not to be NULL
•	Also filtered the plans_plan to focus on accounts with savings_plan and investment_plan
•	Similar columns been ensured in the two tables, I applied the UNION to append the two tables together
•	Finally, I filtered out all accounts that had more than 365 days of inactivity and displayed them along with the account type and inactivity duration.
________________________________________
4. Assessment_Q4 - Customer Lifetime Value (CLV) Estimation
•	This was about estimating how much value a customer brings over time.
•	The first thing I did was calculate how long each customer has been with us, in months, using the enabled_at date from users_customuser. At first, I was contemplating if I should use date-joined or enabled_at, the I remembered it’s about customers value, so I used enabled_at. So I used the TIMESTAMPDIFF to get the tenure_months
•	I joined this table with savings_savingsaccount to count how many transactions each customer made by counting savings_id
•	Then I used a simple formula to estimate their CLV:
	I divided the total number of transactions by their tenure in months,
	Multiplied that by 12,
	Then multiplied that by the average profit per transaction, which was 0.1% of the amount 
	Everything rounded to two decimal places
•	This gave me a rough but useful estimate of their lifetime value.
•	I filtered the enabled_at not to be NULL
•	I then sorted the results from highest to lowest to see which customers were the most valuable.

