'''
Created on 29-May-2020

@author: vanaja
'''
import can
import sys
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal



class testWindow(QObject): #creating testWindow child class for QObject
    dataChanged = pyqtSignal(int)
    def __init__(self):
        QObject.__init__(self) #calling parent class constructor to initialize QOBject class
    @pyqtSlot()
    def testing(self):
        s=[]
        obj = senderW.findChild(QObject, "test_id")#finding and assigning test_id object
        id = obj.property("text")#extracting text property value to id
        obj = senderW.findChild(QObject, "test_msg")#finding and assigning test_msg object
        dat = obj.property("text")#extracting text property value to dat
        obj = senderW.findChild(QObject, "test_period")#finding and assigning test_period object for whether it is periodic or not
        period = obj.property("text")#extracting text property value to period
        obj = senderW.findChild(QObject, "test_time")#finding and assigning test_time object
        time = obj.property("text")#extracting text property value to time
        obj = senderW.findChild(QObject, "test_type")#finding and assigning test_type object for whether it is standard or extended
        C_type = obj.property("text")#extracting text property value to type
        l=list(dat)#converting dat to list l
        for i in range(0,len(l)-1,2):
            s.append(l[i]+l[i+1])#appending the nearest two values of list l and append to another list s
        if (len(l)-1)%2==0:#for sending single bit or data with odd length
            s.append(l[len(l)-1])
        for i in range(len(s)):
            e=int(s[i],16)#converting to hexa-decimal value
            s[i]=e#saving it as hexa-decimal value
        period=(period=="true")#comparing whether the data is periodic or not
        t=int(id,16)#converting id to hexa-decimal value
        msg = can.Message(arbitration_id=t,data=s,is_extended_id=False)#creating message frame with data
        if(period):#check whether periodic or not
            #for periodic message
            time=int(time)#converting time to integer
            try:
                bus.send_periodic(msg,(time*0.001))
                print("Sent Periodic ID: {}   Data:: {} ".format(id,dat))
            except can.CanError:
                print("Message NOT sent")
        else:
            #for non periodic message
            try:
                bus.send(msg)
                print("Sent Non-Periodic ID:{}   Data: {} ".format(id,dat))
            except can.CanError:
                print("Message NOT sent")
 
if __name__ == "__main__": 
    bus = can.interface.Bus(bustype='socketcan', channel='vcan0', bitrate=250000)#initialize can bus
    app =QApplication(sys.argv)#creating an application object
    engine = QQmlApplicationEngine()#creating an engine object
    currentWindow = testWindow()#creating object of testWindow class and initialize constructor 
    engine.rootContext().setContextProperty("testWindow", currentWindow)#connection between qml and python
    engine.load('canRawSender.qml')#loading qml
    senderW=engine.rootObjects()[0]#senderW object for qml 
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())#to exit window
