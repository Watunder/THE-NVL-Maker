;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="BGM界面编辑"]

[iscript]

//新版背景图
f.uibacklayer=new uiBackLayer(f.config_bgmmode.bgd);

//新建显示用层
f.uilayer=[];

//按钮
f.uilayer[0]=new uiButtonLayer(f.config_bgmmode.up);
f.uilayer[1]=new uiButtonLayer(f.config_bgmmode.down);
f.uilayer[2]=new uiButtonLayer(f.config_bgmmode.back);
f.uilayer[3]=new uiListLayer(f.config_bgmmode.list);

[endscript]

*update

[iscript]
f.uilayer[3].Reset(f.config_bgmmode.list);
f.uilayer[3].drawSelect();
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="BGM界面编辑"]

[iscript]
//描绘底板
drawUIEditorBack();
//--------------------------------------------------------
var start_y=125;

drawFrame("基本设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);
drawEdit("音乐列表",,sf.gs.width+70,start_y+20+30);
[endscript]
 [hlink hint="点此打开列表设置界面" target=*音乐列表]□[endlink]

[iscript]
var start_y=260;

drawFrame("控件设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawButtonSetting("前一页","f.uilayer[0]",sf.gs.width+50,start_y+20);
drawButtonSetting("后一页","f.uilayer[1]",sf.gs.width+50,start_y+20+30);
drawButtonSetting("返回按钮","f.uilayer[2]",sf.gs.width+50,start_y+20+30*2);
//--------------------------------------------------------
DrawPosFrame();
[endscript]
[s]

*音乐列表
[iscript]
f.参数=new Dictionary();
f.参数=f.uilayer[3].LayerElm();
[endscript]
[call storage="window_list.ks"]
[iscript]
(Dictionary.assign incontextof f.config_bgmmode.list)(f.参数);
[endscript]
[jump target=*update]


*选择图片
[call storage="window_picture.ks"]
[jump target=*update]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

*确认

[iscript]
//背景信息
f.config_bgmmode.bgd=f.uibacklayer.LayerElm();

//按钮信息
f.config_bgmmode.up=f.uilayer[0].ButtonElm();
f.config_bgmmode.down=f.uilayer[1].ButtonElm();
f.config_bgmmode.back=f.uilayer[2].ButtonElm();

//列表信息
f.config_bgmmode.list=f.uilayer[3].LayerElm();

//保存
SaveDic(f.config_bgmmode,"uibgmmode.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_bgmmode=LoadDic("uibgmmode.tjs");
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
