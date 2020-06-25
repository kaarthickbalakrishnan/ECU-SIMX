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
        self.filename =" "
        self.path_3 =" "
        self.in_file =""
        self.filename_4=""
        
    
    @pyqtSlot()
    def browse_in(self):
        input_Path=senderW.findChild(QObject,"inputPath")
#         textIn = input_Path.property("text")
        self.filename = QFileDialog.getOpenFileName()
        path = self.filename[0]
        input_Path.setProperty("text", path)
        self.in_file =str(path)
    @pyqtSlot()
    def browse_out(self): 
        outputformat_Obj = senderW.findChild(QObject, "output_format")
        output_file_format = outputformat_Obj.property("currentText")
        output_Path=senderW.findChild(QObject,"outputPath")
        self.filename_1 = QFileDialog.getSaveFileName()
        self.filename_4 =str(self.filename_1[0])+'.'+output_file_format
        path_1 = self.filename_4
        output_Path.setProperty("text", path_1)   

    @pyqtSlot()
    def excel(self):
        input_Path=senderW.findChild(QObject,"inputPath")
        self.filename_2 = QFileDialog.getSaveFileName()
        self.path_3 = str(self.filename_2[0]+'.xlsx')
        workbook= xlsxwriter.Workbook(self.path_3)
        worksheet= workbook.add_worksheet('sheet')
        a=0
        b=0
        column=["ID","Frame Name","Cycle Time [ms]","Launch Type","Launch Parameter",    "Signal Byte No.",    "Signal Bit No.",    "Signal Name",    "Signal Function",    "Signal Length [Bit]",    "Signal Default",    "Signal Not Available",    "Byteorder",    "Value",    "Name / Phys. Range",    "Function / Increment Unit"]
        for i in range (len(column)): #loop for adding 1000 messages
            worksheet.write(a,b,column[i])# a ,b were the respective excel cell and within qutoes you can add your messages
            b=b+1
        workbook.close() #closing the file
        self.in_file =str(self.path_3)
        input_Path.setProperty("text", self.path_3)
        
    @pyqtSlot()
    def edit_(self):
        webbrowser.open_new(r'file:'+str(self.in_file))
        
    @pyqtSlot()
    def viewHelpDoc(self):
        webbrowser.open_new(r'file:helpDoc.pdf')

    @pyqtSlot()
    def convert_(self):
        console=senderW.findChild(QObject,"console")        
        s = (str(self.filename_1))    
        output_directory = 'converted_file'
        dpath = os.path.join(s,output_directory) 
        try:
            os.makedirs(dpath)
        except OSError:  
            pass
        
#         out_file = os.path.join(dpath, out_file)
        canmatrix.convert.convert(self.in_file, self.filename_4)
       
        console.append("THE FILE IS GENERATED IN: ")
        console.append(self.filename_4)
    
        
 
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