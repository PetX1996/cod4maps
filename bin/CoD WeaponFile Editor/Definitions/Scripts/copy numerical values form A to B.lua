Dialog.Message("TESTSCRIPT", "I will copy copy numerical values from B to A!", MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);
--SAMPLE SCRIPT BY SHUFFLE
qresult = Dialog.Message("Notice", "Do you proceed? Numerical values will be overwritten!", MB_YESNO, MB_ICONQUESTION, MB_DEFBUTTON1);
if qresult == 6 then
	StatusDlg.Show(MB_ICONNONE, false);
	StatusDlg.SetTitle("Porcessing...");
	StatusDlg.SetMessage("Please wait, processing data...");
	StatusDlg.SetStatusText("Analizing numerical values...");
	StatusDlg.ShowProgressMeter(false);
	numProcLog = "PROCESS LOG"
	rcount2 = Grid.GetRowCount("Grid2");
	rcount1 = Grid.GetRowCount("Grid1");
	isLoaded = false
	i=1
	while i <= rcount2 do
		gVal2 = Grid.GetCellText("Grid2", i, 1);
		if gVal2 == "0" or String.ToNumber(gVal2) ~= 0 then
			gAtt2 = Grid.GetCellText("Grid2", i, 0);
			j=1
			while j <= rcount1 do
				gAtt1 = Grid.GetCellText("Grid1", j, 0);
				gVal1 = Grid.GetCellText("Grid1", j, 1);
				if gAtt1 == gAtt2 and gVal1 ~= gVal2 then
					Grid.SetCellText("Grid1", j, 1, gVal2, false);	
					Grid.SetCellColors("Grid1", j, 1, {Background=changedcol,Text=0}, false);	
					Grid.SetCellColors("Grid2", i, 1, {Background=changedcol,Text=0}, false);	
					numProcLog = numProcLog .. "\r\n " .. gAtt1 .. ": " .. gVal1 .. " to " .. gVal2
				end
				j=j+1
			end
		end						
		i=i+1
	end
	isLoaded = true
	StatusDlg.Hide();
	Grid.Refresh("Grid1");
	StatusBar.SetStatus("Processing completed!");
	DialogEx.Show("Log", true, nil, nil);
end