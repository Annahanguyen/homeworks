#This script will calculate  
# * The total number of votes cast
# * A complete list of candidates who received votes
# * The percentage of votes each candidate won
# * The total number of votes each candidate won
# * The winner of the election based on popular vote.

import os
import csv
#Create a path across operating systems 
csvpath = os.path.join("Resources", "election_data.csv")

#make empty lists for the columns
column_three = []
count = 0
votes_each_candidate = []
percentage_each_candidate = []
final_results = []

#Read the csv file
with open(csvpath) as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ',')
    csv_header = next(csvreader)
    for row in csvreader:
        #Add values from rows in empty lists
        candidates = row[2]
        column_three.append(candidates)
    
    #Find the total number of votes cast
    total_votes_cast = len(column_three)

    #Find a complete list of candidates who received votes
    column_three_set = set(column_three)
    candidate_list = list(column_three_set)
    
    #Find the total number of votes each candidate won
    for candidate in column_three_set:
        votes_each = column_three.count(candidate)
        votes_each_candidate.append(votes_each)

    #Find the percentage of votes each candidate won
    for votes in votes_each_candidate:
        percentage_each = round(int(votes)/int(total_votes_cast)*100)
        round(percentage_each)
        percentage_each_candidate.append(percentage_each)
    
    #Create a dictionary
    votes_dictionary = {candidate_list[i]: votes_each_candidate[i] for i in range(len(candidate_list))}
    #Find the winner of the election based on the most vote
    winning_candidate = max(votes_dictionary, key=votes_dictionary.get)
#Print out all results
print("Election Results")
print("----------------------------")
print(f"Total Votes: {total_votes_cast}")
print("----------------------------")
for count in range(len(candidate_list)):
    print(f"{candidate_list[count]}: {percentage_each_candidate[count]}% ({votes_each_candidate[count]})")
print("----------------------------")
print(f"Winner: {winning_candidate}")

# save the output file path
txtfile_path = os.path.join("analysis","output.txt")
f = open(txtfile_path, "w")
f.write("Election Results\n")
f.write("----------------------------\n")
f.write(f"Total Votes: {total_votes_cast}\n")
f.write("----------------------------\n")
for count in range(len(candidate_list)):
    f.write(f"{candidate_list[count]}: {percentage_each_candidate[count]}% ({votes_each_candidate[count]})\n")
f.write("----------------------------\n")
f.write(f"Winner: {winning_candidate}\n")

f.close()