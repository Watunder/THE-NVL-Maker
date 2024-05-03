;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;历史记录设定窗口
;背景,文字样式,文字区域
;上下按钮,返回按钮,滚动条
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="对话履历界面设定"]
[iscript]
//防止出错用
if (f.config_history.slider.width==void) f.config_history.slider.width=20;
if (f.config_history.slider.height==void) f.config_history.slider.height=100;
if (f.config_history.slider.over==void) f.config_history.slider.over=f.config_history.slider.normal;

//新版背景图
f.uibacklayer=new uiBackLayer(f.config_history.bgd);
//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiButtonLayer(f.config_history.up);
f.uilayer[1]=new uiButtonLayer(f.config_history.down);
f.uilayer[2]=new uiButtonLayer(f.config_history.back);
f.uilayer[3]=new uiScrollLayer(f.config_history.slider);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系统界面版面设定"]

[iscript]
//描绘底板
drawUIEditorBack();

//刷新背景
f.uibacklayer.Reset(f.uibacklayer.LayerElm());
//描绘历史记录文字显示范围
demoHistory();
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
drawFrame("基本设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);
drawEdit("文字范围",,sf.gs.width+70,start_y+20+30);
[endscript]
 [hlink hint="点此打开文字范围设定窗口" target=*文字范围]□[endlink]
[iscript]
drawEdit("文字样式",,sf.gs.width+70,start_y+20+30*2);
[endscript]
 [link hint="点此打开文字样式设定窗口" target=*文字样式]□[endlink]
[iscript]
var start_y=260;

drawFrame("控件设定",4,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawButtonSetting("前一页","f.uilayer[0]",sf.gs.width+50,start_y+20);
drawButtonSetting("后一页","f.uilayer[1]",sf.gs.width+50,start_y+20+30);
drawButtonSetting("返回按钮","f.uilayer[2]",sf.gs.width+50,start_y+20+30*2);
//滚动条
drawScrollSetting("滚动条","f.uilayer[3]",sf.gs.width+50,start_y+20+30*3);
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

*文字范围
[iscript]
f.参数=new Dictionary();
f.参数.frame=f.config_history.bgd.frame;
f.参数.marginl=f.config_history.marginl;
f.参数.marginr=f.config_history.marginr;
f.参数.margint=f.config_history.margint;
f.参数.marginb=f.config_history.marginb;
[endscript]
[call storage="window_margin_param.ks"]
[iscript]
f.config_history.marginl=(int)f.参数.marginl;
f.config_history.marginr=(int)f.参数.marginr;
f.config_history.margint=(int)f.参数.margint;
f.config_history.marginb=(int)f.参数.marginb;
[endscript]
[jump target=*window]

*文字样式
[iscript]
//复制历史记录文字样式
f.参数=new Dictionary();
(Dictionary.assign incontextof f.参数)(f.config_history.font);
[endscript]
[call storage="window_historyfont.ks"]
[iscript]
//回写
(Dictionary.assign incontextof f.config_history.font)(f.参数);
[endscript]
[jump target=*window]

*滚动条
[call storage="window_scroll.ks"]
[jump target=*window]

*确认
[iscript]
//背景信息
f.config_history.bgd=f.uibacklayer.LayerElm();

//按钮,滚动条信息
f.config_history.up=f.uilayer[0].ButtonElm();
f.config_history.down=f.uilayer[1].ButtonElm();
f.config_history.back=f.uilayer[2].ButtonElm();
f.config_history.slider=f.uilayer[3].ScrollElm();

//保存字典
SaveDic(f.config_history,"uihistory.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_history=LoadDic("uihistory.tjs");
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
