;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;询问窗口设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="询问窗口"]

[iscript]
//新版背景图
f.uibacklayer=new uiBackLayer(f.config_yesno.bgd);
//新建显示用层
f.uilayer=[];
//按钮
f.uilayer[0]=new uiButtonLayer(f.config_yesno.btnyes);
f.uilayer[1]=new uiButtonLayer(f.config_yesno.btnno);
//消息文字
f.uilayer[2]=new uiYNMsgLayer(getTransStr("红色十字代表对齐锚点"),f.config_yesno.msg);
[endscript]

*update
[iscript]
//--------------------------------------------------------
//消息文字
f.uilayer[2].Reset(f.config_yesno.msg);

//所有层全部不选中
for (var i=0;i<f.uilayer.count;i++)
{
   f.uilayer[i].select=false;
   f.uilayer[i].drawSelect();
}
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="询问窗口"]

[iscript]
//描绘底板
drawUIEditorBack();
//--------------------------------------------------------
var start_y=125;
drawFrame("基本设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);
drawEdit("文字样式",,sf.gs.width+70,start_y+20+30);
[endscript]
 [hlink hint="点此打开文字样式设置界面" target=*文字样式]□[endlink]
[iscript]

var start_y=260;

drawFrame("控件设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawButtonSetting("确认","f.uilayer[0]",sf.gs.width+50,start_y+20);
drawButtonSetting("取消","f.uilayer[1]",sf.gs.width+50,start_y+20+30);

DrawPosFrame();
[endscript]
[s]

*文字样式
[iscript]
f.参数=new Dictionary();
f.参数=f.uilayer[2].TextElm();
[endscript]
[call storage="window_ynmsg.ks"]
[iscript]
(Dictionary.assign incontextof f.config_yesno.msg)(f.参数);
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
f.config_yesno.bgd=f.uibacklayer.LayerElm();
//按钮信息
f.config_yesno.btnyes=f.uilayer[0].ButtonElm();
f.config_yesno.btnno=f.uilayer[1].ButtonElm();
f.config_yesno.msg=f.uilayer[2].TextElm();

//保存字典
SaveDic(f.config_yesno,"uiyesno.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_yesno=LoadDic("uiyesno.tjs");
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

