# -*- coding: utf-8 -*-
#
import logging
import wx
import wx.grid
import json
import os
import uuid
import datetime

class MainGridTable(wx.grid.PyGridTableBase):
    def __init__(self):
        wx.grid.PyGridTableBase.__init__(self)
        self.data = {}

    def GetNumberRows(self):
        return 18

    def GetNumberCols(self):
        return 4

    def GetValue(self, row, col):
        value = self.data.get((row, col))
        if value is not None:
            return value
        else:
            return ''

    def SetValue(self, row, col, value):
        self.data[(row, col)] = value

    def GetColLabelValue(self, col):
        colLabelValues = ('名词', '动词', '褒义词', '贬义词')
        if col >= 0 or col <4:
            return colLabelValues[col]
        return ''
        

class MainFrame(wx.Frame):
    def __init__(self):
        wx.Frame.__init__(self, None, -1, 'jsonmaker', size = (600, 450))
        panel = wx.Panel(self, -1)

        # 创建菜单及快捷键
        accellist = []
        menuBar = wx.MenuBar()
        menu = wx.Menu()
        menuitem = menu.Append(-1, '打开')
        self.Bind(wx.EVT_MENU, self.OnOpen, menuitem)
        accellist.append((wx.ACCEL_CMD, ord('o'), menuitem.GetId()))

        menuitem = menu.Append(-1, '新建')
        self.Bind(wx.EVT_MENU, self.OnNew, menuitem)
        accellist.append((wx.ACCEL_CMD, ord('N'), menuitem.GetId()))

        menuitem = menu.Append(-1, '保存')
        self.Bind(wx.EVT_MENU, self.OnSave, menuitem)
        accellist.append((wx.ACCEL_CMD, ord('S'), menuitem.GetId()))

        menuitem = menu.Append(-1, '关闭')
        self.Bind(wx.EVT_MENU, self.OnQuit, menuitem)
        accellist.append((wx.ACCEL_CMD, ord('Q'), menuitem.GetId()))

        menuBar.Append(menu, '文件')
        self.SetMenuBar(menuBar)
        self.SetAcceleratorTable(wx.AcceleratorTable(accellist))

        vSizer = wx.BoxSizer(wx.VERTICAL)

        # 名称
        label = wx.StaticText(panel, -1, '名称：')
        self.nameTextCtrl = wx.TextCtrl(panel, -1)

        sizer = wx.BoxSizer(wx.HORIZONTAL)
        sizer.Add(label, 0, wx.ALL, 5)
        sizer.Add(self.nameTextCtrl, 1, wx.ALL | wx.EXPAND, 5)
        vSizer.Add(sizer, 0, wx.ALL | wx.EXPAND, 5)

        # 网格
        self.grid = wx.grid.Grid(panel, -1)
        self.gridTable = MainGridTable()
        self.grid.SetTable(self.gridTable, True)
        vSizer.Add(self.grid, 1, wx.ALL | wx.EXPAND, 5)

        panel.SetSizer(vSizer)
        
        self.id = None
        self.createTime = None
        self.data = None
        self.filename = ''
        self.conf = {}
        if os.path.exists('config.conf'):
            with open('config.conf', 'rb') as f:
                self.conf = json.JSONDecoder().decode(f.read())

    def OnOpen(self, event):
        file_wildcard = 'json file(*.json) | *.json'
        filedir = os.getcwd()
        if self.conf.has_key('filedir') and os.path.exists(self.conf['filedir']):
            filedir = self.conf['filedir']
        dlg = wx.FileDialog(self, '打开json文件', filedir, style = wx.OPEN)
        if dlg.ShowModal() != wx.ID_OK:
            return

        self.filename = dlg.GetPath()
        self.conf['filedir'] = os.path.dirname(self.filename)
        self.SetTitle(self.filename)
        with open(self.filename, 'rb') as f:
            self.data = json.JSONDecoder().decode(f.read().decode('utf8'))
        self.nameTextCtrl.SetValue(self.data['title'])
        wordKeys = ('verbs', 'terms', 'commendatories', 'derogratories')
        for col in range(4):
            words = self.data[wordKeys[col]]
            row = 0
            for word in words:
                self.gridTable.SetValue(row, col, word)
                row += 1
        self.grid.ForceRefresh()

    def OnNew(self, event):
        pass

    def OnSave(self, event):
        file_wildcard = 'json files(*.json) | *.json'
        if self.filename == None or len(self.filename) == 0:
            dlg = wx.FileDialog(self, '保存json文件', os.getcwd(), style = wx.SAVE)
            if dlg.ShowModal() != wx.ID_OK:
                return
            self.filename = dlg.GetPath()
            self.SetTitle(self.filename)
            self.conf['filedir'] = os.path.dirname(self.filename)
            
        if self.data == None:
            self.data = {}
        
        if len(self.data['id']) == 0:
            self.data['id'] = unicode(uuid.uuid1())
        self.data['title'] = self.nameTextCtrl.GetValue()
        self.data['createTime'] = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        wordKeys = ('verbs', 'terms', 'commendatories', 'derogratories')
        for col in range(4):
            words = []
            rows = self.grid.GetNumberRows()
            for row in range(rows):
                words.append(self.gridTable.GetValue(row, col))
            wordKey = wordKeys[col]
            self.data[wordKey] = words

        with open(self.filename, 'wb') as f:
            f.write(json.JSONEncoder().encode(self.data).encode('utf8'))
        logging.debug('保存成功！')

    def OnQuit(self, event):
        with open('config.conf', 'wb') as f:
            f.write(json.JSONEncoder().encode(self.conf))
        wx.Exit()

class MainApp(wx.App):
    def __init__(self, redirect = False, filename = None):
        wx.App.__init__(self, redirect, filename)

    def OnInit(self):
        self.frame = MainFrame()
        self.frame.Show()
        self.SetTopWindow(self.frame)
        return True

class Main(object):
    def Main(self):
        app = MainApp()
        app.MainLoop()

if __name__ == '__main__':
    loggingFormat = '%(asctime)s %(lineno)04d %(levelname)-8s %(message)s'
    logging.basicConfig(level=logging.DEBUG, format=loggingFormat, datefmt='%H:%M', )
    main = Main()
    main.Main()
