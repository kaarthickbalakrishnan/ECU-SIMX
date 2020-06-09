'''
Created on 08-Jun-2020

https://www.learnpyqt.com/courses/concurrent-execution/multithreading-pyqt-applications-qthreadpool/


@author: manz
'''

from PyQt5.Qt import QApplication
from PyQt5.QtCore import pyqtSignal
from PyQt5.QtWidgets import QMainWindow, QWidget, QPlainTextEdit, QVBoxLayout, QPushButton
import sys
import can
import time
import struct
from typing import Dict, Tuple, Union
from threading import Thread

class bus_Cofing ():
    def __init__(self):
        self.channel = 'vcan0'
        self.interface = 'socketcan'
        self.bitrate = 250000
        self.filter = ['120:FF0'] #, '140:7BF']
        self.data_structs = Dict[Union[int, Tuple[int, ...]], Union[struct.Struct, Tuple, None]]

class CanViewer:
    def __init__(self, bus, data_structs, testing=False):
        self.bus = bus
        self.data_structs = data_structs

        # Initialise the ID dictionary, start timestamp, scroll and variable for pausing the viewer
        self.ids = {}
        self.start_time = None
        self.scroll = 0
        self.paused = False
        self.newEntry = ""

        if not testing:  # pragma: no cover
            self.run()

    def run(self):
        # Clear the terminal and draw the header
#         self.draw_header()

        while 1:
            # Do not read the CAN-Bus when in paused mode
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
        arbitration_id_string = "0x{0:0{1}X}".format(
            msg.arbitration_id, 8 if msg.is_extended_id else 3)
        
        can_data_string = (["{:#02x}".format(byte) for byte in msg.data])

        # Now create the CAN-Bus message to GUI Window
        self.newEntry = ""
        
        self.newEntry += str(self.ids[key]["count"]) + '\t'
        self.newEntry += "{0:.6f}".format(self.ids[key]["msg"].timestamp - self.start_time) + '\t'
        self.newEntry += "{0:.6f}".format(self.ids[key]["dt"]) + '\t'
        self.newEntry += arbitration_id_string + '\t'
        self.newEntry += str(msg.dlc) + '\t'
        self.newEntry += str(can_data_string)
        #append Data on GUI
        self.logToViewer(self.newEntry)
        
    def logToViewer(self,text):
        window.emit(text)

class GUIWindow(QMainWindow):
    new_record = pyqtSignal(object)
    
    def __init__(self, *args, **kwargs):
        super(GUIWindow, self).__init__(*args, **kwargs)
    
        layout = QVBoxLayout()
        
        self.logView = QPlainTextEdit(self)
        self.logView.setReadOnly(True)  
        self.logView.appendPlainText("Count\tTime\tDiff.Time\tCAN ID\tDLC\tCAN Message\n")
        self.logView.move(10,10)
        self.logView.resize(800,500)
        
        self.btn = QPushButton("Play / Pause")
        self.btn.setCheckable(True)
        self.btn.pressed.connect(self.startView)
    
        layout.addWidget(self.logView)
        layout.addWidget(self.btn)
        
        self.new_record.connect(self.logView.appendPlainText)
    
        w = QWidget()
        w.setLayout(layout)
    
        self.setCentralWidget(w)
    
        self.show()

    def emit(self, record):
        msg = record
        self.new_record.emit(str(msg)) # <---- emit signal here
 
    def startView(self):
       if self.btn.isChecked():
          self.emit("Play Button Pressed")
       else:
          self.emit("Pause Button Pressed")

app = QApplication([])
window = GUIWindow()
window.setWindowTitle("CAN Viewer")
window.resize(900, 500)

class gui_App (Thread):  
    def __init__(self):
        Thread.__init__(self)
        
    def launch(self):
        app.exec_()

class canView(Thread):
    def __init__(self):
        Thread.__init__(self)
        
    def run(self):
#         print("Test")
#         window.emit("fromVeiew")
        
        localConfig = bus_Cofing ()
        config = {"single_handle": True}
        
    #     config["can_filters"] = localConfig.filter
        config["interface"] = localConfig.interface
        config["bitrate"] = localConfig.bitrate
        
        data_structs = localConfig.data_structs
        
        # Create a CAN-Bus interface
        bus = can.Bus(localConfig.channel, **config)
        print('\nConnected to {}: {}'.format(bus.__class__.__name__, bus.channel_info))
        
        CanViewer(bus, data_structs)

if __name__ == '__main__':
    #Threads
    canViewThread = canView()
    guiAppThread = gui_App()
    
    canViewThread.start()
    guiAppThread.start()
    #Launch GUI
    sys.exit(guiAppThread.launch())
