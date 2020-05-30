'''
Created on 21-May-2020
Reference: https://qmlbook.github.io/ch18-python/python.html

@author: manzoor
'''
import sys
from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

class testWindow(QObject):
    dataChanged = pyqtSignal(int)
    nextNumber = pyqtSignal(int)
    
    def __init__(self):
        QObject.__init__(self)
    
    @pyqtSlot()
    def sendBtn_Click(self):
        print("Send Button Clicked")


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    currentWindow = testWindow()
    engine.rootContext().setContextProperty("testWindow", currentWindow)
    
    engine.load(QUrl("btnGUI.qml"))
    senderW = engine.rootObjects()[0]
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec_())
