import os
import sys
from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import  QFileDialog, QApplication
import canmatrix.convert


class Edb_editor(QObject):
    dataChanged = pyqtSignal(int)
    nextNumber = pyqtSignal(int)
    textChanged = pyqtSignal()
    global path
    
    @pyqtSlot()
    def browse(self):
        self.open_dialog_box()

        
           
    @pyqtSlot() 
    def open_dialog_box(self): 
        textArea1=senderW.findChild(QObject,"INPUT_PATH")
        self.filename = QFileDialog.getOpenFileName()
        path = self.filename[0]
        textArea1.append(path) 
    
    @pyqtSlot()
    def browse_1(self):
        self.open_dialog_box_1()

        
           
    @pyqtSlot() 
    def open_dialog_box_1(self): 
        textArea=senderW.findChild(QObject,"viewPanelText")
        self.filename_1 = QFileDialog.getExistingDirectory()
        path_1 = self.filename_1
        textArea.append(path_1)      


    @pyqtSlot()
    def convert_(self):
        textArea2=senderW.findChild(QObject,"console")
        out_Obj = senderW.findChild(QObject, "output_in")
        output_file_base = str(out_Obj.property("text"))
        outputformat_Obj = senderW.findChild(QObject, "output_format")
        output_file_format = outputformat_Obj.property("currentText")
        in_file = str(self.filename[0])
        out_file = os.path.basename(output_file_base)
        out_file += '.' + output_file_format
        s = (str(self.filename_1))    
        output_directory = 'converted_file'
        dpath = os.path.join(s,output_directory) 
        try:
            os.makedirs(dpath)
        except OSError:
                
            pass
        out_file = os.path.join(dpath, out_file)
        canmatrix.convert.convert(in_file, out_file)
       
        textArea2.append("THE FILE IS GENERATED AND STORED IN")
        textArea2.append(out_file) 
    
        
 
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