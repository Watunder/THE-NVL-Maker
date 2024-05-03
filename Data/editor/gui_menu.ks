;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;游戏选单设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="主选单设定"]
[iscript]
//新版背景图
f.uibacklayer=new uiBackLayer(f.config_menu.bgd);
//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_menu.save);
f.uilayer[1]=new uiButtonLayer(f.config_menu.load);
f.uilayer[2]=new uiButtonLayer(f.config_menu.option);
f.uilayer[3]=new uiButtonLayer(f.config_menu.history);

f.uilayer[4]=new uiButtonLayer(f.config_menu.other);
f.uilayer[5]=new uiButtonLayer(f.config_menu.exit);
f.uilayer[6]=new uiButtonLayer(f.config_menu.totitle);
f.uilayer[7]=new uiButtonLayer(f.config_menu.back);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="主选单设定"]
[iscript]
//描绘底板
drawUIEditorBack();
//--------------------------------------------------------
//刷新图层
      //所有层全部不选中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
var start_y=125;
drawFrame("基本设定",1,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);

var start_y=200;

drawFrame("按钮",8,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawButtonSetting("保存游戏","f.uilayer[0]",sf.gs.width+50,start_y+20);
drawButtonSetting("读取进度","f.uilayer[1]",sf.gs.width+50,start_y+20+30);
drawButtonSetting("系统设定","f.uilayer[2]",sf.gs.width+50,start_y+20+30*2);
drawButtonSetting("历史记录","f.uilayer[3]",sf.gs.width+50,start_y+20+30*3);

drawButtonSetting("自定选单","f.uilayer[4]",sf.gs.width+50,start_y+20+30*4);
drawButtonSetting("离开游戏","f.uilayer[5]",sf.gs.width+50,start_y+20+30*5);
drawButtonSetting("返回标题","f.uilayer[6]",sf.gs.width+50,start_y+20+30*6);
drawButtonSetting("回到游戏","f.uilayer[7]",sf.gs.width+50,start_y+20+30*7);
//--------------------------------------------------------
DrawPosFrame();
[endscript]
[s]


*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

*确认
[iscript]
//背景信息
f.config_menu.bgd=f.uibacklayer.LayerElm();

f.config_menu.save=f.uilayer[0].ButtonElm();
f.config_menu.load=f.uilayer[1].ButtonElm();
f.config_menu.option=f.uilayer[2].ButtonElm();
f.config_menu.history=f.uilayer[3].ButtonElm();

f.config_menu.other=f.uilayer[4].ButtonElm();
f.config_menu.exit=f.uilayer[5].ButtonElm();
f.config_menu.totitle=f.uilayer[6].ButtonElm();
f.config_menu.back=f.uilayer[7].ButtonElm();

//保存字典
SaveDic(f.config_menu,"uimenu.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_menu=LoadDic("uimenu.tjs");
//清除背景/按钮
deleteUILayers();
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
