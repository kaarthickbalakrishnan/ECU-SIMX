'''
Created on 15-May-2020
Reference: https://qmlbook.github.io/ch18-python/python.html

@author: manz
'''
import sys
from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
  
import can
bus = can.interface.Bus(bustype='socketcan', channel='vcan0', bitrate=250000)

class CAN_Sender(QObject):
    dataChanged = pyqtSignal(int)
    nextNumber = pyqtSignal(int)
    
    def __init__(self):
        QObject.__init__(self)

#     @Slot()
#     def giveNumber(self):
#         self.nextNumber.emit(10)
    
    @pyqtSlot()
    def getCAN_message(self):
        data_Obj = senderW.findChild(QObject, "canData_in")
        id_Obj = senderW.findChild(QObject, "canID_in")
        C_data = data_Obj.property("text")
        dataList = list(C_data.split(" "))   # Convert text List (space difference)
        h_dataList = [int(i,16) for i in dataList]  # convert list items to Hex Values
        C_ID = int(id_Obj.property("text"),16)
        
        periodicEn_Obj = senderW.findChild(QObject, "periodicEnable")
        periodic_En = periodicEn_Obj.property("checked")
        
        if periodic_En:
            period_Obj = senderW.findChild(QObject, "period_in")
            period = int(period_Obj.property("text"),16)
            msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False)
            try:
                bus.send_periodic(msg,(period*0.001))
                print("Sent Periodic ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
            except can.CanError:
                print("Message NOT sent")
        else:                     
            msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False)
            try:
                bus.send(msg)
                print("Sent ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
            except can.CanError:
                print("Message NOT sent")

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    can_Sender = CAN_Sender()
    engine.rootContext().setContextProperty("canSender", can_Sender)
    
    engine.load(QUrl("main.qml"))
    senderW = engine.rootObjects()[0]
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())
