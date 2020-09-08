VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub Stockmarket()
    ' Create variables
    Dim ws As Integer
    Dim Summary_Table_Row As Integer
    Dim Ticker_name As String
    Dim Yearly_Change_Value As Double
    Dim Percent_Change_Value As Double
    Dim Total_Stock_Volumn As Double
    Dim First_Day_Value As Double
    Dim Last_Day_Value As Double
    Dim LastRow As Double
       
    ' Loop through all sheets
    For ws = 1 To Sheets.Count
        Sheets(ws).Activate
        
    ' Attribute titles to rows
    Range("I1").Value = "Ticker"
    Range("J1").Value = "Yearly Change"
    Range("K1").Value = "Percent Change"
    Range("L1").Value = "Total Stock Volume"
    Range("O2").Value = "Greatest % Increase"
    Range("O3").Value = "Greatest % Decrease"
    Range("O4").Value = "Greatest Total Volume"
    Range("P1").Value = "Ticker"
    Range("Q1").Value = "Value"
        
    ' Attribute initial values for variables
    Summary_Table_Row = 1
    yearly_change = 0
    Percent_Change_Value = 0
    Total_Stock_Volumn = 0
    First_Day_Value = 0
        ' Count the numbers of rows
        LastRow = Range("A" & Rows.Count).End(xlUp).Row
        ' Loop through the rows
        For i = 2 To LastRow
            
            ' Insert value for the ticker column
            Ticker_name = Cells(i, 1).Value
            
            'Get stock value of the first day of the year
            If First_Day_Value = 0 Then
                First_Day_Value = Cells(i, 3).Value
            End If
            
            'Insert values for total stock volumn
                Total_Stock_Volumn = Total_Stock_Volumn + Cells(i, 7).Value
            
            'Search for when the value in rows changes
            If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
            
            'add summary table row everytime loop reaches a different ticker in ws
            Summary_Table_Row = Summary_Table_Row + 1
                Range("I" & Summary_Table_Row).Value = Ticker_name
                
            'Get stock value for the last day of the year
                Last_Day_Value = Cells(i, 6).Value
            
            'Get stock value for the yearly change
                yearly_change = (Last_Day_Value - First_Day_Value)
            
            'print price change in destination
                Range("J" & Summary_Table_Row).Value = yearly_change
            
            'Get stock value for the percent change
                If First_Day_Value = 0 Then
                    Percent_Change_Value = 0
                Else
                    Percent_Change_Value = yearly_change / First_Day_Value
                End If
            'format percent_change_value as a percentage and print into destination
            Range("K" & Summary_Table_Row).Value = Format(Percent_Change_Value, "percent")
            
            'Insert values for total stock volumn
             Range("L" & Summary_Table_Row).Value = Total_Stock_Volumn
             
            'Reset the total stock volumn
                Total_Stock_Volumn = 0
                First_Day_Value = 0
                
            'Colour in the yearly changes
            If yearly_change > 0 Then
                Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
            ElseIf yearly_change < 0 Then
                Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
            End If
            
            
            End If
            
    Next i
    
    'Challenge: find the greatest values
    
                'Attribute initial variables for greateast changes
                greatest_percent_increase = Cells(2, 11).Value
                greatest_percent_increase_ticker = Cells(2, 9).Value
                greatest_percent_decrease = Cells(2, 11).Value
                greatest_percent_decrease_ticker = Cells(2, 9).Value
                greatest_stock_volume = Cells(2, 12).Value
                greatest_stock_volume_ticker = Cells(2, 9).Value
        
        For j = 2 To LastRow
            'Find the greatest percent increase and their tickers
                If Range("K" & j).Value > greatest_percent_increase Then
                    greatest_percent_increase = Range("K" & j).Value
                    greatest_percent_increase_ticker = Range("K" & j).Value
                End If
                
            'Find the greatest percent decrease and their tickers
                If Range("K" & j).Value < greatest_percent_decrease Then
                    greatest_percent_decrease = Range("K" & j).Value
                    greatest_percent_decrease_ticker = Range("K" & j).Value
                End If
                
            'Find the greatest stock volumn and their tickers
                If Cells(i, 12).Value > greatest_stock_volume Then
                    greatest_stock_volume = Cells(i, 12).Value
                    greatest_stock_volume_ticker = Cells(i, 9).Value
                End If
        Next j
            
            ' Add the values to table
            Range("P2").Value = greatest_percent_increase_ticker
            Range("Q2").Value = greatest_percent_increase
            Range("Q2").NumberFormat = "0.00%"
            Range("P3").Value = greatest_percent_decrease_ticker
            Range("Q3").Value = greatest_percent_decrease
            Range("Q3").NumberFormat = "0.00%"
            Range("P4").Value = greatest_stock_volume_ticker
            Range("Q4").Value = greatest_stock_volume

    
    Next ws
    
End Sub

