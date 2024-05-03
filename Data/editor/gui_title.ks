;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;标题画面设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="标题画面设定"]
[iscript]

//新版背景图
f.uibacklayer=new uiBackLayer(f.config_title.bgd);

//新建显示用层
f.uilayer=[];

//按钮和按钮名字对应表
tf.btnlist=["start","load","option","exit","extra","cgmode","endmode","bgmlist","url","addon"];
tf.btnname=["开始游戏","读取进度","系统设定","离开游戏","特别模式","CG收集","结局收集","音乐列表","网址跳转","自定选单"];

for (var i=0;i<tf.btnlist.count;i++)
{
	var btn=tf.btnlist[i];

	if (f.config_title[btn] !== void) 
	{
		f.uilayer[i]=new uiButtonLayer(f.config_title[btn]);
	}
	else
	{
		f.config_title[btn]=%[];
		f.config_title[btn]=CopyDic(f.config_title.start);
		f.config_title[btn].use=false;
		f.uilayer[i]=new uiButtonLayer(f.config_title[btn]);
	}
}

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="标题画面设定"]

[iscript]
//描绘底板
drawUIEditorBack();
//--------------------------------------------------------
//前景图层
if (f.config_title.front!=void) with(kag.fore.layers[11])
{
   .left=kag.fore.layers[4].left;
   .top=kag.fore.layers[4].top;
   .visible=true;
   .loadImages(%["storage"=>f.config_title.front]);
}
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

drawFrame("基本设定",5,sf.gs.width+40,start_y,kag.fore.layers[3],140);
drawEdit("小组标志",,sf.gs.width+70,start_y+20);
drawLink_Picwin("f.config_title.logo","others",,);
//背景图形
drawBackLayerSetting("背景图形","f.uibacklayer",sf.gs.width+70,start_y+20+30);

drawEdit("背景音乐",,sf.gs.width+70,start_y+20+30*2);
drawLink_Win("f.config_title.bgm","music");

drawEdit("画面特效",,sf.gs.width+70,start_y+20+30*3);
[endscript]
 [link hint="点此打开画面特效设定窗口" target=*选择特效]□[endlink]
[iscript]

drawEdit("前景图片",,sf.gs.width+70,start_y+20+30*4);
[endscript]
 [link hint="点此打开前景图片设定界面" target=*前景设定]□[endlink]

[iscript]
var start_y=325;

drawFrame("按钮",10,sf.gs.width+40,start_y,kag.fore.layers[3],140);

for (var i=0;i<tf.btnlist.count;i++)
{
	var btn=tf.btnlist[i];
	var btnname=tf.btnname[i];

	drawButtonSetting(btnname,"f.uilayer["+i+"]",sf.gs.width+50,start_y+20+30*i);
}

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

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择特效
[call storage="window_weather.ks"]
[jump target=*window]

*背景设定
[call storage="window_bgd.ks"]
[jump target=*window]

*前景设定
[iscript]
f.参数=new Dictionary();
var mydic=f.config_title;

f.参数.front=mydic.front;
f.参数.front_x=mydic.front_x;
f.参数.front_y=mydic.front_y;

[endscript]
[call storage="window_frontpic.ks"]
[iscript]
mydic.front=f.参数.front;
mydic.front_x=f.参数.front_x;
mydic.front_y=f.参数.front_y;
[endscript]
[jump target=*window]

*确认
[iscript]
//背景信息
f.config_title.bgd=f.uibacklayer.LayerElm();
//按钮信息
for (var i=0;i<tf.btnlist.count;i++)
{
	var btn=tf.btnlist[i];
	f.config_title[btn]=f.uilayer[i].ButtonElm();
}

//保存字典
SaveDic(f.config_title,tf.title_filename);
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_title=LoadDic(tf.title_filename);
//清除背景/按钮
deleteUILayers();
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[freeimage layer="11"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
