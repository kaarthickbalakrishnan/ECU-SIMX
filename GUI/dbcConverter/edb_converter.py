import os
import sys
from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import  QFileDialog, QApplication
import canmatrix.convert


class Edb_editor(QObject):
    global path
    
    @pyqtSlot()
    def browse_in(self):
        input_Path=senderW.findChild(QObject,"inputPath")
        textIn = input_Path.property("text")
        self.filename = QFileDialog.getOpenFileName()
        path = self.filename[0]
        print(path)
        input_Path.setProperty("text", path)
    
    @pyqtSlot()
    def browse_out(self): 
        output_Path=senderW.findChild(QObject,"outputPath")
        self.filename_1 = QFileDialog.getExistingDirectory()
        path_1 = self.filename_1[0]
        output_Path.setProperty("text", path_1)   


    @pyqtSlot()
    def convert_(self):
        console=senderW.findChild(QObject,"console")
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
       
        console.append("THE FILE IS GENERATED IN: ")
        console.append(out_file)
    
        
 
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