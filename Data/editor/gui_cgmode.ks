;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="CG界面编辑"]

[iscript]

//新版背景图
f.uibacklayer=new uiBackLayer(f.config_cgmode.bgd);
//新建显示用层
f.uilayer=[];

//按钮
f.uilayer[0]=new uiButtonLayer(f.config_cgmode.up);
f.uilayer[1]=new uiButtonLayer(f.config_cgmode.down);
f.uilayer[2]=new uiButtonLayer(f.config_cgmode.back);

[endscript]

*update
[iscript]
//--------------------------------------------------------
//清空档案按钮层
for (var i=3;i<f.uilayer.count;i++)
{
  f.uilayer[i]=void;
}
//强制设定f.uilayer.count的值
f.uilayer.count=f.config_cgmode.locate.count+3;
//--------------------------------------------------------
//重建
for (var i=0;i<f.config_cgmode.locate.count;i++)
{
  f.uilayer[i+3]=new uiCgThumLayer(f.config_cgmode.locate[i],f.config_cgmode.thum);
}

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="CG界面编辑"]


[iscript]
//描绘底板
drawUIEditorBack();
//--------------------------------------------------------
//刷新图层
      //所有层全部不选中
      for (var i=0;i<f.config_cgmode.locate.count+3;i++)
      {
         if (f.uilayer[i].select==true)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
//--------------------------------------------------------
var start_y=125;

drawFrame("基本设定",3,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);
drawEdit("CG按钮",,sf.gs.width+70,start_y+20+30);
[endscript]
 [hlink hint="点此打开CG缩略图细节设定窗口" target=*缩略图设置]□[endlink]
[iscript]
drawEdit("每页图数",,sf.gs.width+70,start_y+20+30*2);
[endscript]
 [hlink hint="点此打开CG缩略图数量设定窗口" target=*缩略图数量]□[endlink]
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

*缩略图数量
[call storage="window_cgthum.ks"]
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

*缩略图设置
[iscript]
f.参数=new Dictionary();
f.参数.thum=f.config_cgmode.thum.thum;
f.参数.x=f.config_cgmode.thum.x;
f.参数.y=f.config_cgmode.thum.y;

f.参数.normal=f.config_cgmode.thum.normal;
f.参数.over=f.config_cgmode.thum.over;
f.参数.on=f.config_cgmode.thum.on;
f.参数.enterse=f.config_cgmode.thum.enterse;
f.参数.clickse=f.config_cgmode.thum.clickse;
[endscript]
[call storage="window_cgbutton.ks"]
[iscript]
f.config_cgmode.thum.thum=f.参数.thum;
f.config_cgmode.thum.x=f.参数.x;
f.config_cgmode.thum.y=f.参数.y;
f.config_cgmode.thum.normal=f.参数.normal;
f.config_cgmode.thum.over=f.参数.over;
f.config_cgmode.thum.on=f.参数.on;
f.config_cgmode.thum.enterse=f.参数.enterse;
f.config_cgmode.thum.clickse=f.参数.clickse;
[endscript]

[jump target=*update]

*确认

[iscript]
//背景信息
f.config_cgmode.bgd=f.uibacklayer.LayerElm();
//按钮信息
f.config_cgmode.up=f.uilayer[0].ButtonElm();
f.config_cgmode.down=f.uilayer[1].ButtonElm();
f.config_cgmode.back=f.uilayer[2].ButtonElm();

//各缩略图的位置记录
for (var i=0;i<f.config_cgmode.locate.count;i++)
{
  f.config_cgmode.locate[i][0]=f.uilayer[i+3].left;
  f.config_cgmode.locate[i][1]=f.uilayer[i+3].top;
}
//保存
SaveDic(f.config_cgmode,"uicgmode.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_cgmode=LoadDic("uicgmode.tjs");
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
