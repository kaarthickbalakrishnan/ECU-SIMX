import sys
import can
from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

class BUS_configure(QObject):
    dataChanged = pyqtSignal(int)
    nextNumber = pyqtSignal(int)
    
    def __init__(self):
        QObject.__init__(self)
        self.bus=" " #To access "bus" anywhere in the class

    
    @pyqtSlot()
    def getBUS_configuration(self):
            bus_Obj = senderW.findChild(QObject, "bustype_in") #Finding the widget based on its object name
            ch_Obj = senderW.findChild(QObject, "channel_in")#Finding the widget based on its object name
            bit_Obj = senderW.findChild(QObject, "bitrate_in")#Finding the widget based on its object name
            bustype = bus_Obj.property("currentText")#Fetching the details from the identified widget named as bus_obj
            channel = ch_Obj.property("currentText")#Fetching the details from the identified widget named as ch_obj
            bitrate = int(bit_Obj.property("text"))#Fetching the details from the identified widget named as bit_obj
            self.bus = can.interface.Bus(bustype=bustype, channel=channel, bitrate=bitrate)#assigning the respective value to the fields inorder to configure bus
            print("THE BUS HAS BEEN INITIATED")
            print("bustype=",bustype,"\nchannel=",channel,"\nbitrate=",bitrate)
            
    @pyqtSlot() 
    def send_can(self):  #This function is to check whether the bus is configured or not by sending one simple can message
            h_dataList = [11,22,33,44,55,66,77,88]  #sample can data
            C_ID = 0x012 #sample can id       
            msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False) #initiating can message
            try:
                self.bus.send(msg) #sending can message to the bus
                print("MESSAGE sent \nMSG ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
            except can.CanError:
                print("Message NOT sent")


if __name__ == '__main__':   #The  main function which allows QML and PYTHON to work collaboratively
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    bus_configure = BUS_configure()   #invoking the class by assigning it to a variable
    engine.rootContext().setContextProperty("busconfigure", bus_configure) ##Rooting the GUI for its response 
    
    engine.load("busConfigWin.qml")# To load qml script
    senderW = engine.rootObjects()[0] #to identify the object names in the GUI
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_()) #For executing the whole process