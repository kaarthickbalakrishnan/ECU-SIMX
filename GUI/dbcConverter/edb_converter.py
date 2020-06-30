import os
import sys
from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import  QFileDialog, QApplication
import canmatrix.convert
import xlsxwriter
import webbrowser


class Edb_editor(QObject):
    global path
    def __init__(self):
        QObject.__init__(self)
        self.createPath = ""
        self.outDir = ""
        
    
    @pyqtSlot()
    def browse(self):
        browse_Path=senderW.findChild(QObject,"inputPath")
        browse_PathFilename = QFileDialog.getOpenFileName()
        PathFilename = str(browse_PathFilename[0])
        browse_Path.setProperty("text", PathFilename)
        
    @pyqtSlot()
    def browse_create(self):
        create_Path=senderW.findChild(QObject,"inputPath")
        self.createPath = str(QFileDialog.getExistingDirectory())
        create_Path.setProperty("text", self.createPath)  
        
    @pyqtSlot()
    def browse_out(self): 
        output_Path=senderW.findChild(QObject,"outputPath")
        self.outDir = str(QFileDialog.getExistingDirectory())
        output_Path.setProperty("text", self.outDir)
          
    
    @pyqtSlot()
    def exec_fn(self):
        console=senderW.findChild(QObject,"console")
        selctFn_Obj = senderW.findChild(QObject, "function_select")
        fn_Selected = selctFn_Obj.property("currentText")
        
        if(fn_Selected == 'Create'):
            new_Filename = senderW.findChild(QObject,"newFileName")
            newFilename= str(new_Filename.property("text"))# new File Name
            newFilename += '.xlsx'
            
            newfilePath = os.path.join((self.createPath),newFilename)
                       
            workbook= xlsxwriter.Workbook(newfilePath)
            worksheet= workbook.add_worksheet('sheet')
            a=0
            b=0
            column=["ID","Frame Name","Cycle Time [ms]","Launch Type","Launch Parameter",    "Signal Byte No.",    "Signal Bit No.",    "Signal Name",    "Signal Function",    "Signal Length [Bit]",    "Signal Default",    "Signal Not Available",    "Byteorder",    "Value",    "Name / Phys. Range",    "Function / Increment Unit"]
            for i in range (len(column)): #loop for adding 1000 messages
                worksheet.write(a,b,column[i])# a ,b were the respective excel cell and within qutoes you can add your messages
                b=b+1
            workbook.close() #closing the file
            
            new_Path=senderW.findChild(QObject,"inputPath")
            new_Path.setProperty("text", str(newfilePath))
            
            console.append("New Excel Template is Created: ")
            console.append(newfilePath) #appending the location and the file name of the output file to the text area to display in GUI
        
            # open the Created Sheet to Edit
            webbrowser.open_new(r'file:'+str(newfilePath))
            
        elif(fn_Selected == 'Editor'):
            input_Path=senderW.findChild(QObject,"inputPath")
            editFile = input_Path.property("text")
            # open the Existing Sheet to Edit
            webbrowser.open_new(r'file:'+str(editFile))
            
        
    @pyqtSlot()
    def viewHelpDoc(self):
        webbrowser.open_new(r'file:helpDoc.pdf')

    @pyqtSlot()
    def convert_(self):
        console=senderW.findChild(QObject,"console")        
        textArea2=senderW.findChild(QObject,"console") #text area in the GUI is found in order to append the path
        out_Obj = senderW.findChild(QObject, "outputPath")#the input textfield is found to get the output file name
        inFile_Path=senderW.findChild(QObject,"inputPath")
        
        output_file_base = str(out_Obj.property("text"))# the preferred name is fetched from the widget in the gui
        outputformat_Obj = senderW.findChild(QObject, "output_format")#the widget is found to get the file format
        output_file_format = outputformat_Obj.property("currentText")#the value is retrieved from the widget (combo box) 
        
                
        outputformat_Obj = senderW.findChild(QObject, "output_format")
        output_name=senderW.findChild(QObject,"outFilename")
        
        output_file_format = outputformat_Obj.property("currentText")
        outName = output_name.property("text")
        out_file = os.path.basename(outName)#user preferred output file name is appended
        out_file += '.' + output_file_format#output file format is appended to the filename
        
        
        outPath = self.outDir
        output_directory = 'converted_file'#the separate folder is created to store the output file in preferred directory to avoid confusion
        dpath = os.path.join(outPath,output_directory) #the preferred directory for  folder is directed
        
        try:
            os.makedirs(dpath)#the above mentioned folder in the directory is created
        except OSError:   
            pass
        
        
        in_file = str(inFile_Path.property("text")) # Path Choosed for input 
        out_file = os.path.join(dpath, out_file)#the created location is directed to the output file
        canmatrix.convert.convert(in_file, out_file)#the conversion is takes place here and output file is generated

        console.append("The file is Generated and Stored in: ")
        console.append(out_file) #appending the location and the file name of the output file to the text area to display in GUI
        
 
if __name__ == '__main__':
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    edb_editor = Edb_editor()
    engine.rootContext().setContextProperty("edb", edb_editor)
    
    engine.load("edb_converter.qml")
    senderW = engine.rootObjects()[0]
    if not engine.rootObjects():
        sys.exit(-1)    
        

    sys.exit(app.exec_())