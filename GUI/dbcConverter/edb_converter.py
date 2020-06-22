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
    
    @pyqtSlot()
    def browse(self): #The function will be invoked on clicking the browse file button (for input file)
        self.open_dialog_box()  #to select the input file we are calling "open_dialog_box()" function

        
           
    @pyqtSlot() 
    def open_dialog_box(self): #this function is to implement the browsing file feature
        textArea1=senderW.findChild(QObject,"INPUT_PATH")  #finding the text widget in the GUI  by object name given in qml script
        self.filename = QFileDialog.getOpenFileName()#File name is browsed and stored in the variabe
        path = self.filename[0] #getting the actual filename to append in the text area
        textArea1.append(path) #Appending the path to the text area
        
    # this block of code  is to get the user preferable location to store the output file
        
    @pyqtSlot()
    def browse_1(self):#The function will be invoked on clicking the browse directory button (for output file)
        self.open_dialog_box_1() #to select the output directory we are calling "open_dialog_box_1()" function

        
           
    @pyqtSlot() 
    def open_dialog_box_1(self): #this function is to implement the browsing directory feature
        textArea=senderW.findChild(QObject,"viewPanelText") #finding the text widget in the GUI  by object name given in qml script
        self.filename_1 = QFileDialog.getExistingDirectory()# Directory name is browsed and stored in the variable
        path_1 = self.filename_1 #getting the actual directory name to append in the text area
        textArea.append(path_1)     #Appending the path to the text area  


    # this block of code is to convert the file to user preferred  file format
    @pyqtSlot()
    def convert_(self):
        textArea2=senderW.findChild(QObject,"console") #text area in the GUI is found in order to append the path
        out_Obj = senderW.findChild(QObject, "output_in")#the input textfield is found to get the output file name
        output_file_base = str(out_Obj.property("text"))# the preferred name is fetched from the widget in the gui
        outputformat_Obj = senderW.findChild(QObject, "output_format")#the widget is found to get the file format
        output_file_format = outputformat_Obj.property("currentText")#the value is retrieved from the widget (combo box) 
        in_file = str(self.filename[0])#previously browsed input file is fed as input file 
        out_file = os.path.basename(output_file_base)#user preferred output file name is appended
        out_file += '.' + output_file_format#output file format is appended to the filename
        s = (str(self.filename_1))  #user preferred directory to store the output is stored to a variable   
        output_directory = 'converted_file'#the separate folder is created to store the output file in preferred directory to avoid confusion
        dpath = os.path.join(s,output_directory) #the preferred directory for  folder is directed
        try:
            os.makedirs(dpath)#the above mentioned folder in the directory is created
        except OSError:
                
            pass
        out_file = os.path.join(dpath, out_file)#the created location is directed to the output file
        canmatrix.convert.convert(in_file, out_file)#the conversion is takes place here and output file is generated
       
        textArea2.append("THE FILE IS GENERATED AND STORED IN")
        textArea2.append(out_file) #appending the location and the file name of the output file to the text area to display in GUI
    
        
 
if __name__ == '__main__':  #The  main function which allows QML and PYTHON to work collaboratively
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    edb_editor = Edb_editor()#invoking the class by assigning it to a variable
    engine.rootContext().setContextProperty("edb", edb_editor) ##Rooting the GUI for its response 
    
    engine.load("edb_converter.qml")# To load qml script
    senderW = engine.rootObjects()[0] #to identify the object names in the GUI
    if not engine.rootObjects():
        sys.exit(-1)    
        

    sys.exit(app.exec_())#For executing the whole process