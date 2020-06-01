'''
Created on 30-May-2020

@author: manzoor
'''

import sys
from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

class mainWindow(QObject):    
    def __init__(self):
        QObject.__init__(self)
    
#     @pyqtSlot()
#     def sendBtn_Click(self):
#         print("Send Button Clicked")


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    currentWindow = mainWindow()
    engine.rootContext().setContextProperty("mainWindow", currentWindow)
    
#     engine.load(QUrl("main1.qml"))
    engine.load(QUrl("main2.qml"))
#     engine.load(QUrl("main3.qml"))
    senderW = engine.rootObjects()[0]
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())