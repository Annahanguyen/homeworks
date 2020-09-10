import os
import csv
#Create a path across operating systems 
csvpath = os.path.join("Resources", "budget_data.csv")

#make empty lists for the columns
column_two = []
column_one = []
monthly_change = []
count = 0

#Read the csv file
with open(csvpath) as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ',')
    csv_header = next(csvreader)
    for row in csvreader:
        #Add values from rows in empty lists
        months = row[0]
        profit_loss = int(row[1])
        column_two.append(profit_loss)
        column_one.append(months)
        
        #Find total months and total profit
        total_month = len(column_one)
        total_change = sum(column_two)
        #Find greatest increase and decrease
        greatest_increase = max(column_two)
        greatest_decrease = min(column_two)
        #Find months for greatest increase and decrease
        x = column_two.index(greatest_increase)
        month_greatest_increase = column_one[int(x)]
        y = column_two.index(greatest_decrease)
        month_greatest_decrease = column_one[int(y)]

    #Find monthly changes
    for count in range(int(total_month)-1):
        monthly_changes = column_two[int(count)+1] - column_two[int(count)]
        monthly_change.append(monthly_changes)
    #Find average changes
    average_change = round(sum(monthly_change)/len(monthly_change))

    #print out the results
    print("Total Months:", total_month)
    print("Total:", total_change)    
    print("Average change:", average_change)
    print("Greatest increase in Profits:", month_greatest_increase, "$",greatest_increase)
    print("Greatest decrease in Profits:", month_greatest_decrease, "$", greatest_decrease) 

Result = (
   f"Financial Analysis\n"
   f"----------------------------\n"
   f"Total Months: ${total_month}\n"
   f"Total: {total_change}\n"
   f"Average  Change: ${average_change}\n"
   f"Greatest increase in Profits: {month_greatest_increase} (${greatest_increase})\n"
   f"Greatest decrease in Profits: {month_greatest_decrease} (${greatest_decrease})\n")

# save the output file path
output = os.path.join("analysis","output.txt")
# open the output file, write Results in the text file
with open(output, "w") as txt_file:
    txt_file.write(Result)
