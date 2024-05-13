;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;地图编辑窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="地图界面"]
[iscript]
//新版背景图
f.uibacklayer=new uiBackLayer(f.config_map[0].bgd);
//创建层
f.uilayer=[];
for (var i=0;i<f.config_map.count-1;i++)
{
f.uilayer[i]=new uiAdvButtonLayer(f.config_map[i+1]);
}
[endscript]
;---------------------------------------------------------------
*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="地图界面"]
[iscript]
//--------------------------------------------
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
//--------------------------------------------
//设定界面
var start_y=125;
drawFrame("基本设定",1,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20);

//设定界面
var start_y=200;

drawFrame("按钮设定",15,sf.gs.width+40,200,kag.fore.layers[3],start_y);
//据点编辑
for (var i=0;i<f.config_map.count-1;i++)
{
	var str=f.uilayer[i].place;
	if (str!=void) str=str.substr(0,7);
	else str="Btn"+"%02d".sprintf(i+1);
	drawMapButtonSetting(str,"f.uilayer["+i+"]",sf.gs.width+50,start_y+20+i*30);
}

DrawPosFrame();
[endscript]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]


*按钮设定
[call storage="window_advbutton.ks"]
[jump target=*window]


*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

*确认
[iscript]
//背景信息
f.config_map[0].bgd=f.uibacklayer.LayerElm();
//按钮信息
for (var i=0;i<f.uilayer.count;i++)
{
f.config_map[i+1]=f.uilayer[i].ButtonElm();
}
//保存
f.config_map.saveStruct(sf.path+"nvl/"+f.mapname);
[endscript]

*关闭选单
[iscript]
//清除背景/按钮
deleteUILayers();
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[return]
