import os, random, openpyxl, shutil

# For Strontium:
#FilePath = '/Users/nathansmac/Desktop/VTA_INPUTS/Strontium/batch4/binary'
#DestinationFile = '/Users/nathansmac/Desktop/VTA_INPUTS/Strontium/batch4'
#WorkbookName = 'Strontium_2021_directory.xlsx'
#SheetName = 'batch4'
#first = False

# For Minis:
#FilePath = '/Users/nathansmac/Desktop/mIPSC_2020/batch3/binary'
#DestinationFile = '/Users/nathansmac/Desktop/mIPSC_2020/batch3'
#WorkbookName = 'mIPSC_2020_directory.xlsx'
#SheetName = 'batch3'
#first = False
# Will need to move the excel file into batch3 folder before running

# For sIPSCs:
#FilePath = '/Users/nathansmac/Desktop/sIPSC_destination/Files_Cut/abf'
#DestinationFile = '/Users/nathansmac/Desktop/sIPSC_destination/Files_Cut'
#WorkbookName = 'sIPSC_blinded.xlsx'
#heetName = 'blinded'
#irst = True

def FileBlinder(FilePath, DestinationFile, WorkbookName, SheetName, first):

	names = sorted(os.listdir(FilePath))   # Creates list of my recording

	randomized = random.sample(range(1,(len(names))+1), (len(names)))     # Creates a list of randomized integers for randomizing my data
	if first == True:
		wb = openpyxl.Workbook()    # Creates a new excel spreadsheet
		directory = wb.create_sheet()
		directory.title = SheetName
	else:
		WorkbookName = os.path.join(DestinationFile, WorkbookName)
		wb = openpyxl.load_workbook(WorkbookName)    # Creates a new excel spreadsheet
		directory = wb.create_sheet()
		directory.title = SheetName

	directory['A1'] = 'recording name'
	directory['B1'] = 'randomized #'

	for n in range(len(names)):
	    directory.cell(3+n, 1, value=names[n])
	for n in range(len(randomized)):
	    directory.cell(3+n, 2, value=randomized[n])
	WorkbookName = os.path.join(DestinationFile, WorkbookName)
	wb.save(WorkbookName)

	BlindedFile = os.path.join(DestinationFile, 'Blinded')

	os.makedirs(BlindedFile)

	for n in range(len(names)):
	    oldfileName = os.path.join(FilePath, names[n])
	    randomizedFile = str(randomized[n]) + '.abf'
	    newfileName = os.path.join(BlindedFile, randomizedFile)
	    shutil.copy(oldfileName, newfileName)
