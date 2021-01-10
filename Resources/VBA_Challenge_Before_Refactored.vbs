Sub AllStockAnalysis()

   Dim startTime As Single
    Dim endTime  As Single

    '0) Collect the data sheet name from user where to run the analysis on
        
        DataSheetName = InputBox("What year would you like to run the analysis on?Please enter the Data sheet name:")
    'Remember time when macro starts
            startTime = Timer
  
      '1) Format the output sheet on All Stocks Analysis worksheet
      
        Worksheets("All Stocks Analysis").Activate
        'Worksheets("All Stocks Analysis").Cells.ClearContents 'clear contents if re-running the module
        'MsgBox ("All Stocks Analysis") 'Msgbox to confirm clear contents function is working.
    
        Range("A1").Value = "All Stocks (" + DataSheetName + ")"
    
        'Create a header row
        Cells(3, 1).Value = "Ticker"
        Cells(3, 2).Value = "Total Daily Volume"
        Cells(3, 3).Value = "Return"
        
    '2) Initialize array of all tickers
        Dim tickers(12) As String

        tickers(0) = "AY"
        tickers(1) = "CSIQ"
        tickers(2) = "DQ"
        tickers(3) = "ENPH"
        tickers(4) = "FSLR"
        tickers(5) = "HASI"
        tickers(6) = "JKS"
        tickers(7) = "RUN"
        tickers(8) = "SEDG"
        tickers(9) = "SPWR"
        tickers(10) = "TERP"
        tickers(11) = "VSLR"
   '3a) Initialize variables for starting price and ending price
        Dim startingPrice As Double
        Dim endingPrice As Double
   '3b) Activate data worksheet
        Worksheets(DataSheetName).Activate
   '3c) Get the number of rows to loop over
        RowCount = Cells(Rows.Count, "A").End(xlUp).Row
   '4) Loop through tickers
   For i = 0 To 11
          '3b) Activate data worksheet
            Worksheets(DataSheetName).Activate
       ticker = tickers(i)
       '5) loop through rows in the data
       For j = 2 To RowCount
           '5a) Get total volume for current ticker
           If Cells(j, 1).Value = ticker Then

                totalVolume = totalVolume + Cells(j, 8).Value

            End If
           '5b) get starting price for current ticker
           If Cells(j - 1, 1).Value <> ticker And Cells(j, 1).Value = ticker Then

                    startingPrice = Cells(j, 6).Value

            End If
           '5c) get ending price for current ticker
           If Cells(j + 1, 1).Value <> ticker And Cells(j, 1).Value = ticker Then

                endingPrice = Cells(j, 6).Value
            End If

       Next j
       '6) Output data for current ticker
       Worksheets("All Stocks Analysis").Activate
        Cells(4 + i, 1).Value = ticker
        Cells(4 + i, 2).Value = totalVolume
        Cells(4 + i, 3).Value = endingPrice / startingPrice - 1

   Next i
   
       'Formatting
    Worksheets("All Stocks Analysis").Activate
    Range("A3:C3").Font.FontStyle = "Bold"
    Range("A3:C3").Borders(xlEdgeBottom).LineStyle = xlContinuous
    Range("B4:B15").NumberFormat = "#,##0"
    Range("C4:C15").NumberFormat = "0.0%"
    Columns("B").AutoFit

    dataRowStart = 4
    dataRowEnd = 15

    For i = dataRowStart To dataRowEnd
        
        If Cells(i, 3) > 0 Then
            
            Cells(i, 3).Interior.Color = vbGreen
            
        Else
        
            Cells(i, 3).Interior.Color = vbRed
            
        End If
        
    Next i
 
   
    endTime = Timer
    MsgBox "This code ran in " & (endTime - startTime) & " seconds for the year " & (yearValue)

   
End Sub