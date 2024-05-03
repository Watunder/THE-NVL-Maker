;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;对话界面设定窗口
;---------------------------------------------------------------
*start
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="对话界面版面设定"]
[iscript]
//描绘底板
drawUIEditorBack();

//在背景上添加图片
f.uilayer=[];

//全屏对话框
f.uilayer[0]=new uiMessageLayer(f.config_dia.scr);
f.uilayer[0].visible=false;
//普通对话框
f.uilayer[1]=new uiMessageLayer(f.config_dia.dia);
//头像
//载入头像大小
var sizelayer=new Layer(kag, kag.fore.stage);
sizelayer.loadImages("face_setting_sample");
sizelayer.setSizeToImageSize();
      
f.uilayer[2]=new uiLayer(%[
							"left"=>f.config_dia.face.left-sizelayer.width\2,
							"top"=>f.config_dia.face.top-sizelayer.height,
							"frame"=>"face_setting_sample"
                          ]);
//把头像也默认不显示了吧，阿门
f.uilayer[2].visible=false;
//各按钮
//save
f.uilayer[3]=new uiButtonLayer(f.config_dia.save);
//load
f.uilayer[4]=new uiButtonLayer(f.config_dia.load);
//skip
f.uilayer[5]=new uiButtonLayer(f.config_dia.skip);
//auto
f.uilayer[6]=new uiButtonLayer(f.config_dia.auto);
//history
f.uilayer[7]=new uiButtonLayer(f.config_dia.history);
//option
f.uilayer[8]=new uiButtonLayer(f.config_dia.option);
//hide
f.uilayer[9]=new uiButtonLayer(f.config_dia.hide);
//menu
f.uilayer[10]=new uiButtonLayer(f.config_dia.menu);
//other
f.uilayer[11]=new uiButtonLayer(f.config_dia.other);

if (f.config_dia.nameframe==void)
{
	f.config_dia.nameframe=%[
		"frame"=>"extra_bgmbutton_normal",
		"visible"=>0
		];
}

f.uilayer[12]=new uiFrameLayer(getTransStr("文字样式"),f.config_dia.nameframe);

[endscript]

*window
[window_down width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="对话界面版面设定"]
[iscript]
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

drawFrame("消息层",5,sf.gs.width+40,start_y,kag.fore.layers[3],140);

drawEdit("透明框边距",,sf.gs.width+60,start_y+20);
[endscript]
 [hlink hint="点此打开边距设定窗口" target=*透明框]□[endlink]
[iscript]
drawView("全屏框","f.uilayer[0]",sf.gs.width+60,start_y+20+30,"*全屏框");
drawView("对话框","f.uilayer[1]",sf.gs.width+60,start_y+20+30*2,"*对话框");
drawView("头像位","f.uilayer[2]",sf.gs.width+60,start_y+20+30*3,"*头像位置");
if (f.config_dia.nameframe!=void)
{
	drawView("姓名栏","f.uilayer[12]",sf.gs.width+60,start_y+20+30*4,"*姓名栏");
}
//--------------------------------------------------------
var start_y=320;


drawFrame("系统按钮",11,sf.gs.width+40,start_y,kag.fore.layers[3],140);

drawButtonSetting("存储按钮","f.uilayer[3]",sf.gs.width+50,start_y+20);
drawButtonSetting("读取按钮","f.uilayer[4]",sf.gs.width+50,start_y+20+30);
drawButtonSetting("快速略过","f.uilayer[5]",sf.gs.width+50,start_y+20+30*2);
drawButtonSetting("自动前进","f.uilayer[6]",sf.gs.width+50,start_y+20+30*3);
drawButtonSetting("历史记录","f.uilayer[7]",sf.gs.width+50,start_y+20+30*4);
drawButtonSetting("系统设定","f.uilayer[8]",sf.gs.width+50,start_y+20+30*5);
drawButtonSetting("隐藏窗口","f.uilayer[9]",sf.gs.width+50,start_y+20+30*6);
drawButtonSetting("主选单","f.uilayer[10]",sf.gs.width+50,start_y+20+30*7);
drawButtonSetting("自定选单","f.uilayer[11]",sf.gs.width+50,start_y+20+30*8);

DrawPosFrame();
//--------------------------------------------------------
[endscript]
[s]

*透明框
[iscript]
      //所有层全部不选中
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
[endscript]
;打开margin设定窗口
[iscript]
f.参数=new Dictionary();
f.参数.marginl=f.config_dia.blank.marginl;
f.参数.marginr=f.config_dia.blank.marginr;
f.参数.margint=f.config_dia.blank.margint;
f.参数.marginb=f.config_dia.blank.marginb;
f.参数.frame="empty";
[endscript]
[call storage="window_margin.ks"]
[iscript]
f.config_dia.blank.marginl=f.参数.marginl;
f.config_dia.blank.marginr=f.参数.marginr;
f.config_dia.blank.margint=f.参数.margint;
f.config_dia.blank.marginb=f.参数.marginb;
[endscript]
[jump target=*window]

*全屏框
[iscript]
f.参数=f.uilayer[0].MessageElm();
[endscript]
[call storage="window_frame.ks"]
[iscript]
f.uilayer[0].Reset(f.参数);
[endscript]
[jump target=*window]

*对话框
[iscript]
f.参数=f.uilayer[1].MessageElm();
[endscript]
[call storage="window_frame.ks"]
[iscript]
f.uilayer[1].Reset(f.参数);
[endscript]
[jump target=*window]

*头像位置
[iscript]
//复制历史记录文字样式
f.参数=new Dictionary();
f.参数.left=f.uilayer[2].left;
f.参数.top=f.uilayer[2].top;
[endscript]
[call storage="window_buttonlocate.ks"]
[iscript]
f.uilayer[2].left=f.参数.left;
f.uilayer[2].top=f.参数.top;
[endscript]
[jump target=*window]

*按钮设定
[call storage="window_sysbutton.ks"]
[jump target=*window]

*姓名栏
[iscript]
f.参数=f.uilayer[12].LayerElm();
[endscript]
[call storage="window_textframe.ks"]
[iscript]
f.uilayer[12].Reset(f.参数);
[endscript]
[jump target=*window]

*确认
;保存
[iscript]
//透明框已经复制

//复制对话框信息
f.config_dia.scr=f.uilayer[0].MessageElm();
f.config_dia.dia=f.uilayer[1].MessageElm();
f.config_dia.face.left=f.uilayer[2].left+sizelayer.width\2;
f.config_dia.face.top=f.uilayer[2].top+sizelayer.height;

//复制按钮信息
f.config_dia.save=f.uilayer[3].ButtonElm();
f.config_dia.load=f.uilayer[4].ButtonElm();
f.config_dia.skip=f.uilayer[5].ButtonElm();
f.config_dia.auto=f.uilayer[6].ButtonElm();
f.config_dia.history=f.uilayer[7].ButtonElm();
f.config_dia.option=f.uilayer[8].ButtonElm();
f.config_dia.hide=f.uilayer[9].ButtonElm();
f.config_dia.menu=f.uilayer[10].ButtonElm();
f.config_dia.other=f.uilayer[11].ButtonElm();

//复制姓名栏信息
if (f.config_dia.nameframe!=void)
{
	f.config_dia.nameframe=f.uilayer[12].LayerElm();
}

//保存字典
SaveDic(f.config_dia,"uidia.tjs");
[endscript]

*关闭选单
;重载字典
[iscript]
f.config_dia=LoadDic("uidia.tjs");
delete f.uilayer;
delete sizelayer;
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
