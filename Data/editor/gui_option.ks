;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;系统界面设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系统界面版面设定"]
[iscript]

//兼容处理
if (f.config_option.cvvolume==void) 
{
	f.config_option.cvvolume=CopyDic(f.config_option.back);
	f.config_option.cvvolume.use=false;
}
if (f.config_option.reset==void) 
{
	f.config_option.reset=CopyDic(f.config_option.back);
	f.config_option.reset.use=false;
}
if (f.config_option.self==void) 
{
	f.config_option.self=CopyDic(f.config_option.back);
	f.config_option.self.use=false;
}

//新版背景图
f.uibacklayer=new uiBackLayer(f.config_option.bgd);

//新建显示用层
f.uilayer=[];
f.uilayer[0]=new uiSliderLayer(f.config_option.textspeed);
f.uilayer[1]=new uiSliderLayer(f.config_option.autospeed);

f.uilayer[2]=new uiSliderLayer(f.config_option.bgmvolume);
f.uilayer[3]=new uiSliderLayer(f.config_option.sevolume);

f.uilayer[4]=new uiCheckboxLayer(f.config_option.fullscreen);
f.uilayer[5]=new uiCheckboxLayer(f.config_option.window);

f.uilayer[6]=new uiCheckboxLayer(f.config_option.allskip);
f.uilayer[7]=new uiCheckboxLayer(f.config_option.readskip);

f.uilayer[8]=new uiButtonLayer(f.config_option.totitle);
f.uilayer[9]=new uiButtonLayer(f.config_option.endgame);

f.uilayer[10]=new uiButtonLayer(f.config_option.back);

f.uilayer[11]=new uiSliderLayer(f.config_option.cvvolume);
f.uilayer[12]=new uiButtonLayer(f.config_option.reset);
[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="系统界面版面设定"]

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
drawFrame("滑动槽设定",5,sf.gs.width+40,start_y,kag.fore.layers[3],140);

drawSliderSetting("文字速度","f.uilayer[0]",sf.gs.width+50,start_y+20);
drawSliderSetting("自动速度","f.uilayer[1]",sf.gs.width+50,start_y+20+30);
drawSliderSetting("音乐音量","f.uilayer[2]",sf.gs.width+50,start_y+20+30*2);
drawSliderSetting("音效音量","f.uilayer[3]",sf.gs.width+50,start_y+20+30*3);
drawSliderSetting("语音音量","f.uilayer[11]",sf.gs.width+50,start_y+20+30*4);
//--------------------------------------------------------
var start_y=395;

drawFrame("开关",4,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawCheckBoxSetting("全屏显示","f.uilayer[4]",sf.gs.width+50,start_y+20);
drawCheckBoxSetting("窗口显示","f.uilayer[5]",sf.gs.width+50,start_y+20+30);
drawCheckBoxSetting("跳过全部","f.uilayer[6]",sf.gs.width+50,start_y+20+30*2);
drawCheckBoxSetting("只跳已读","f.uilayer[7]",sf.gs.width+50,start_y+20+30*3);
//--------------------------------------------------------
var start_y=560;

drawFrame("按钮",4,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawButtonSetting("返回标题","f.uilayer[8]",sf.gs.width+50,start_y+20);
drawButtonSetting("结束游戏","f.uilayer[9]",sf.gs.width+50,start_y+20+30);
drawButtonSetting("恢复默认","f.uilayer[12]",sf.gs.width+50,start_y+20+30*2);
drawButtonSetting("回到游戏","f.uilayer[10]",sf.gs.width+50,start_y+20+30*3);
//--------------------------------------------------------
DrawPosFrame();

[endscript]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*滑动槽设定
[call storage="window_slider.ks"]
[jump target=*window]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

*开关按钮设定
[call storage="window_checkbox.ks"]
[jump target=*window]

*确认
[iscript]
//背景信息
f.config_option.bgd=f.uibacklayer.LayerElm();

f.config_option.textspeed=f.uilayer[0].SliderElm();
f.config_option.autospeed=f.uilayer[1].SliderElm();
f.config_option.bgmvolume=f.uilayer[2].SliderElm();
f.config_option.sevolume=f.uilayer[3].SliderElm();

//假如存在这个参数
if (f.config_option.cvvolume!=void){
f.config_option.cvvolume=f.uilayer[11].SliderElm();
}

f.config_option.fullscreen=f.uilayer[4].ButtonElm();
f.config_option.window=f.uilayer[5].ButtonElm();
f.config_option.allskip=f.uilayer[6].ButtonElm();
f.config_option.readskip=f.uilayer[7].ButtonElm();
f.config_option.totitle=f.uilayer[8].ButtonElm();
f.config_option.endgame=f.uilayer[9].ButtonElm();
f.config_option.back=f.uilayer[10].ButtonElm();

//假如存在这个参数
if (f.config_option.reset!=void){
f.config_option.reset=f.uilayer[12].ButtonElm();
}

//保存字典
SaveDic(f.config_option,"uioption.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_option=LoadDic("uioption.tjs");
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
