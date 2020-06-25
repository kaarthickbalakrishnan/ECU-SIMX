'''
Created on 10-Jun-2020

@author: vanaja, Manzoor, Hemlatha, Murugeswari
'''

import can
import sys
import time
import struct
from time import sleep
import threading
from typing import Dict, Tuple, Union
import webbrowser

from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QObject, pyqtSlot,pyqtSignal,pyqtProperty

global currentWindow

class guiWindow(QObject): #creating guiWindow child class for QObject
    sig_canViewChanged = pyqtSignal(str)

    def __init__(self):
        QObject.__init__(self) #calling parent class constructor to initialize QOBject class            
        self._viewData = ""
        
    @pyqtSlot()
    def getBUS_configuration(self):
        busCon=busConf()
            
    @pyqtSlot() 
    def send_can(self):  
        sendTry=testMsg()
                
    @pyqtSlot()
    def send(self):
        tWind=tWindow()
    
    @pyqtSlot()
    def playCanView(self):
        if canViewThread.is_alive():
            canViewThread.resume() 
            print("CanViewer Resumed")   
        else:
            canViewThread.start()
            print("CanViewer Started")
            
    @pyqtSlot()
    def pauseCanView(self):    
        canViewThread.pause()
        print("CanViewer Paused")
    
    @pyqtSlot()
    def viewHelpDoc(self):
        webbrowser.open_new(r'file:helpDoc.pdf')
          
    @pyqtProperty(str, notify=sig_canViewChanged)
    def updateView(self): 
        return self._viewData
        
    @updateView.setter
    def updateView(self, s):
        if self._viewData != s:
            self._viewData = s
            self.sig_canViewChanged.emit(s)
            
class tWindow(guiWindow):
    def __init__(self):
        s=[]
        obj = w_SimX.findChild(QObject, "test_id")#finding and assigning test_id object
        id = obj.property("text")#extracting text property value to id
        obj = w_SimX.findChild(QObject, "test_msg")#finding and assigning test_msg object
        dat = obj.property("text")#extracting text property value to dat
        obj = w_SimX.findChild(QObject, "test_period")#finding and assigning test_period object for whether it is periodic or not
        period = obj.property("text")#extracting text property value to period
        obj = w_SimX.findChild(QObject, "test_time")#finding and assigning test_time object
        time = obj.property("text")#extracting text property value to time
        obj = w_SimX.findChild(QObject, "test_type")#finding and assigning test_type object for whether it is standard or extended
        C_type = obj.property("text")#extracting text property value to type
        l=list(dat)#converting dat to list l
        for i in range(0,len(l)-1,2):#to append nearest 2 values
            s.append(l[i]+l[i+1])
            
        if (len(l)-1)%2==0:
            s.append(l[len(l)-1])
            
            
        for i in range(len(s)):
            e=int(s[i],16)#converting to hexa-decimal value
            s[i]=e#saving it as hexa-decimal value
        period=(period=="true")#comparing whether the data is periodic or not
        t=int(id,base=16)#converting id to hexa-decimal value
        msg = can.Message(arbitration_id=t,data=s,is_extended_id=False)#creating message frame with data
        if(period):#check whether periodic or not
            #for periodic message
            time=int(time,10)#converting time to integer
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
                
                
class busConf(guiWindow):
    def __init__(self):
        global bus
        bus_Obj = w_SimX.findChild(QObject, "bustype_in")
        ch_Obj = w_SimX.findChild(QObject, "channel_in")
        bit_Obj = w_SimX.findChild(QObject, "bitrate_in")
        bustype = bus_Obj.property("currentText")
        channel = ch_Obj.property("currentText")
        bitrate = int(bit_Obj.property("text"))
        bus = can.interface.Bus(bustype=bustype, channel=channel, bitrate=bitrate)
        print("THE BUS HAS BEEN INITIATED")
        print("bustype=",bustype,"\nchannel=",channel,"\nbitrate=",bitrate)
        
        
class testMsg(guiWindow):
    def __init__(self):
        h_dataList = []  #empty frame to check channel
        C_ID = 0x012     #id for channel empty message  
        msg = can.Message(arbitration_id=C_ID,data=h_dataList,is_extended_id=False)
        try:
            bus.send(msg)
            print("MESSAGE sent \nMSG ID: " + str(hex(C_ID)) + "\tData: " + str(h_dataList))
        except can.CanError:
            print("Message NOT sent")


class viewer_Cofing ():
    def __init__(self):
        self.filter = ['120:FF0'] #, '140:7BF']
        self.data_structs = Dict[Union[int, Tuple[int, ...]], Union[struct.Struct, Tuple, None]]

class CanViewer():
    def __init__(self, bus, data_structs):
        self.bus = bus
        self.data_structs = data_structs

        # Initialise the ID dictionary, start timestamp, scroll and variable for pausing the viewer
        self.ids = {}
        self.start_time = None
        self.scroll = 0
        self.paused = False
        self.newEntry = ""

    def run(self):
        # Clear the terminal and draw the header
#         self.draw_header()
        if not self.paused:
            # Read the CAN-Bus and draw it in the terminal window
            msg = self.bus.recv(timeout=1.0 / 1000.0)
            if msg is not None:
                self.draw_can_bus_message(msg)
        else:
            # Sleep 1 ms, so the application does not use 100 % of the CPU resources
            time.sleep(1.0 / 1000.0)

    def draw_can_bus_message(self, msg, sorting=False):
        # Use the CAN-Bus ID as the key in the dict
        key = msg.arbitration_id

        # Sort the extended IDs at the bottom by setting the 32-bit high
        if msg.is_extended_id:
            key |= 1 << 32

        new_id_added, length_changed = False, False
        if not sorting:
            # Check if it is a new message or if the length is not the same
            if key not in self.ids:
                new_id_added = True
                # Set the start time when the first message has been received
                if not self.start_time:
                    self.start_time = msg.timestamp
            elif msg.dlc != self.ids[key]["msg"].dlc:
                length_changed = True

            if new_id_added or length_changed:
                # Increment the index if it was just added, but keep it if the length just changed
                row = len(self.ids) + 1 if new_id_added else self.ids[key]["row"]

                # It's a new message ID or the length has changed, so add it to the dict
                # The first index is the row index, the second is the frame counter,
                # the third is a copy of the CAN-Bus frame
                # and the forth index is the time since the previous message
                self.ids[key] = {"row": row, "count": 0, "msg": msg, "dt": 0}
            else:
                # Calculate the time since the last message and save the timestamp
                self.ids[key]["dt"] = msg.timestamp - self.ids[key]["msg"].timestamp

                # Copy the CAN-Bus frame - this is used for sorting
                self.ids[key]["msg"] = msg

            # Increment frame counter
            self.ids[key]["count"] += 1

        # Format the CAN ID&Data as a hex value
        arbitration_id_string = "{0:0{1}X}".format(
            msg.arbitration_id, 8 if msg.is_extended_id else 3)
        
        can_data_string = (["{0:02X}".format(byte) for byte in msg.data])

#         #to convert hex data to decimal data
#         can_data_decimal=[]  #empty list to save decimal converted value
#         for i in range (len(can_data_string)): #fetching each hex value
#             j=int(str(can_data_string[i]),16)  #converting to decimal value
#             can_data_decimal.append((j)) #appending converted decimal value to new list
#         
        # Now create the CAN-Bus message to GUI Window
        self.newEntry = ""
        
        self.newEntry += str(self.ids[key]["count"]) + '\t'
        self.newEntry += "{0:.6f}".format(self.ids[key]["msg"].timestamp - self.start_time) + '\t'
        self.newEntry += "{0:.6f}".format(self.ids[key]["dt"]) + '\t'
        self.newEntry += arbitration_id_string + '\t'
        self.newEntry += str(msg.dlc) + '\t'
        for i  in range (len(can_data_string)):
            self.newEntry += str(can_data_string[i])
            self.newEntry +=str("     ")
        #append Data on GUI
        self.logToViewer(self.newEntry)
      
    def logToViewer(self,text):
        # uncomment the below line print the canView in Console window also
#         print(text)
        currentWindow.updateView = text

class canView(threading.Thread):
    def __init__(self, *args, **kwargs):
        super (canView, self). __init__ (*args, **kwargs)
        self.__flag = threading.Event()  # is used to suspend the thread's identity
        self.__flag.set ()    # set to True
        self.__running = threading.Event()   # to stop the thread's identity
        self.__running.set ()   # Set Running to True
        
    def pause (self):
      self.__flag.clear ()   # set to False to allow threads to block
    
    def resume (self):
      self.__flag.set ()  # set to True to allow thread to stop blocking
    
    def stop (self):
      self.__flag.set ()    # Restores a thread from a paused state. How to have paused
      self.__running.clear ()    # set to False      Thread.__init__(self)
        
    def run(self):     
        localConfig = viewer_Cofing()
        config = {"single_handle": True}
        # config["can_filters"] = localConfig.filter
    
        data_structs = localConfig.data_structs
        currentView = CanViewer(bus, data_structs)
        # Do not read the CAN-Bus when in paused/stopped mode     
        while self.__running.isSet():
            self.__flag.wait ()   # returns immediately when false, blocking until the internal identity bit is true to return            
            currentView.run()
            

class gui_App (threading.Thread):  
    def __init__(self, *args, **kwargs):
        super (gui_App, self). __init__ (*args, **kwargs)
        self.__flag = threading.Event ()   # is used to suspend the thread's identity
        self.__flag.set ()    # set to True
        self.__running = threading.Event ()   # to stop the thread's identity
        self.__running.set ()   # Set Running to True
        
    def pause (self):
      self.__flag.clear ()   # set to False to allow threads to block
    
    def resume (self):
      Self.__flag.set ()  # set to True to allow thread to stop blocking
    
    def stop (self):
      self.__flag.set ()    # Restores a thread from a paused state. How to have paused
      self.__running.clear ()    # set to False  
        
    def launch(self):
        global w_SimX
        global currentWindow
        
        while self.__running.isSet():
            self.__flag.wait ()   # returns immediately when false, blocking until the internal identity bit is true to return        
            
            app =QApplication(sys.argv)#creating an application object
            engine = QQmlApplicationEngine()#creating an engine object
            currentWindow = guiWindow()#creating object of guiWindow class and initialize constructor 
            engine.rootContext().setContextProperty("guiWindow", currentWindow)#connection between qml and python
            engine.load('mainMenu.qml')#loading qml
            w_SimX=engine.rootObjects()[0]  #w_SimX object for qml 
            if not engine.rootObjects():
                sys.exit(-1)
            sys.exit(app.exec_())#to exit window
        
if __name__ == "__main__": 
    #default Bus
    bus = can.interface.Bus(bustype='socketcan', channel='vcan0', bitrate=250000)#initialize can bus
    #Threads
    canViewThread = canView()
    guiAppThread = gui_App()
    
    #Launch GUI
    sys.exit(guiAppThread.launch())
    