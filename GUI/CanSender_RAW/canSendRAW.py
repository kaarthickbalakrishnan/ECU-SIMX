'''
Created on 25-May-2020
Reference: https://qmlbook.github.io/ch18-python/python.html

@author: manz
'''
import sys
from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QTableWidgetItem
  
import can
bus = can.interface.Bus(bustype='socketcan', channel='vcan0', bitrate=250000)

class CAN_SenderRAW(QObject):
    dataChanged = pyqtSignal(int)
    nextNumber = pyqtSignal(int)
    
    def __init__(self):
        QObject.__init__(self)
        
    @pyqtSlot()
    def add_row(self):
        print("Add Row Button Clicked")
#         self.setItem(0,0,QTableWidgetItem('Hello'))
#         row = 0
#         column = 0
#         self.can_table.insertRow(self.can_table.rowCount())
#         QTableWidgetItem *newItem = QTableWidgetItem(tr("%1").arg((row+1)*(column+1)))
#         senderW.can_table.setItem(row, column, "newItem")
#         QTableWidgetItem *newItem = new QTableWidgetItem(tr("%1").arg(
#         (row+1)*(column+1)));
#         tableWidget->setItem(row, column, newItem);

    
    @pyqtSlot()
    def sendCAN_message(self):
        print("Hello Team")
#         periodicEn_Obj = senderW.findChild(QObject, "periodicEnable")
#         period_Obj = senderW.findChild(QObject, "period_in")
#         periodic_En = periodicEn_Obj.property("checked")
#         period = int(period_Obj.property("text"),16)
#          
#         print(period)
#         if periodic_En:
#             data_Obj = senderW.findChild(QObject, "canData_in")
#             id_Obj = senderW.findChild(QObject, "canID_in")
#             C_data = data_Obj.property("text")
#             dataList = list(C_data.split(" "))   # Convert text List (space difference)
#             h_dataList = [int(i,16) for i in dataList]  # convert list items to Hex Values
#             C_ID = int(id_Obj.property("text"),16)
#              
#             msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False)
#             try:
#                 bus.send_periodic(msg,(period*0.001))
#                 print("Sent Periodic ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
#             except can.CanError:
#                 print("Message NOT sent")
#         else:        
#             data_Obj = senderW.findChild(QObject, "canData_in")
#             id_Obj = senderW.findChild(QObject, "canID_in")
#             C_data = data_Obj.property("text")
#             dataList = list(C_data.split(" "))   # Convert text List (space difference)
#             h_dataList = [int(i,16) for i in dataList]  # convert list items to Hex Values
#             C_ID = int(id_Obj.property("text"),16)
#              
#             msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False)
#             try:
#                 bus.send(msg)
#                 print("Sent ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
#             except can.CanError:
#                 print("Message NOT sent")

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    can_SenderRAW = CAN_SenderRAW()
    engine.rootContext().setContextProperty("canSenderRAW", can_SenderRAW)
    
    engine.load(QUrl("main.qml"))
    senderW = engine.rootObjects()[0]
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())
