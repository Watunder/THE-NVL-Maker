;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.
;-------------------------------------------------------------------------------------------
;     This program is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.

;     This program is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;-------------------------------------------------------------------------------------------
[iscript]
//自适应屏幕分辨率
function changeFit() {
	kag.onWindowedMenuItemClick();
	var design = kag.scWidth / kag.scHeight;

	var refWidth =  System.screenWidth;
	var refHeight = System.screenHeight;

	var ref = refWidth / refHeight;

	dm("Reference Size: " + refWidth + "," + refHeight);
	if(ref > design) {
		// use height as reference
		kag.setZoom(refHeight, kag.scHeight);
		kag.setInnerSize(kag.scWidth * refHeight / kag.scHeight, refHeight);
		dm("Height Ref:" + (kag.scWidth * refHeight / kag.scHeight) + "," + refHeight);
	} else {
		kag.setZoom(refWidth, kag.scWidth);
		kag.setInnerSize(refWidth, kag.scHeight * refWidth / kag.scWidth );
		dm("Width Ref: " + refWidth + "," + (kag.scHeight * refWidth / kag.scWidth));
	}
	tf.fit=true;
	//kag.showScrollBars=false;
}

//复原分辨率
function changeOrigin() {
	kag.onWindowedMenuItemClick();
	kag.setZoom(1, 1);
	kag.setInnerSize(kag.scWidth, kag.scHeight);
	tf.fit=false;
	//kag.showScrollBars=true;
}

//默认为不自适应
//changeFit();
[endscript]

*start
[iscript]
//设定数值(game_setting)
//默认值
sf.gs=%[];
sf.gs.width=800;
sf.gs.height=600;
//about里的版本信息
sf.version_num="3.90 beta";
sf.version_date="2018/11/20";
//加入滚动条，如果画面不够大的话就可以拖了……=_=b
//kag.showScrollBars=true;
[endscript]
;---------------------------------------------------------------
;DLL插件
;---------------------------------------------------------------
[loadplugin module="dirlist.dll"]
[loadplugin module="addFont.dll"]
;---------------------------------------------------------------
;层设定
;---------------------------------------------------------------
[laycount messages=9 layers=12]
;底板(框架)
[layopt layer=stage index=1000]
;游戏主菜单
[layopt layer=message0 index=2000]
;-------------------------------------
;底板2(单页背景,描绘文字)
[layopt layer=0 index=3000]
;底板3(事件编辑器描绘)
[layopt layer=1 index=4000]
;编辑器按钮
[layopt layer=message1 index=5000]
;滑动条位置按钮
[layopt layer=2 index=6000]
;右键菜单
[layopt layer=message2 index=7000]
;-------------------------------------
;上层界面底板(界面编辑-window_down)
[layopt layer=3 index=8000]
;上层界面窗口
[layopt layer=message3 index=9000]
;预留
[layopt layer=4 index=10000]
;下拉菜单
[layopt layer=message4 index=11000]
;-------------------------------------
;补充底板(参数输入-window_middle)
[layopt layer=5 index=12000]
;预留
[layopt layer=message5 index=13000]
;预留
[layopt layer=6 index=14000]
;下拉菜单
[layopt layer=message6 index=15000]
;-------------------------------------
;最上层界面底板(文件选择，位置设定window_up)
[layopt layer=7 index=16000]
;预留(特殊描绘)
[layopt layer=8 index=17000]
;菜单
[layopt layer=message7 index=18000]
;滚动条标志位置按钮
[layopt layer=9 index=19000]
;预览图片/取色板
[layopt layer=10 index=20000]
;最上层下拉菜单
[layopt layer=message8 index=21000]
;-------------------------------------
;最上层提示
[layopt layer=event index=30000]
;其他
[layopt layer=11 index=10999]
;---------------------------------------------------------------
;宏
;---------------------------------------------------------------
;文件载入与操作
[call storage="function_load.ks"]
[call storage="function_rws.ks"]

;界面编辑器相关
[call storage="function_ui.ks"]
[call storage="function_ui2.ks"]
[call storage="function_ui3.ks"]

;脚本编辑器相关
[call storage="macro_ui.ks"]

;控件相关
[call storage="class_picpreview_window.ks"]

[call storage="class_uilayer.ks"]
[call storage="class_uiscrolllayer.ks"]
[call storage="class_uisliderlayer.ks"]
[call storage="class_uimessagelayer.ks"]
[call storage="class_uibuttonlayer.ks"]
[call storage="class_uicheckboxlayer.ks"]

[call storage="class_uimapbuttonlayer.ks"]
[call storage="class_uiadvbuttonlayer.ks"]
[call storage="class_getadvlayer.ks"]

[call storage="class_getmarginlayer.ks"]
[call storage="class_uislbutton.ks"]

[call storage="class_uicgthumlayer.ks"]
[call storage="class_uilistlayer.ks"]
[call storage="class_uiynmsglayer.ks"]
[call storage="class_uiframelayer.ks"]

[call storage="class_uibacklayer.ks"]

;多语言UI相关
[call storage="function_translate.ks"]

;导出函数相关


;初始化
[startanchor]
;------------------------------------------------------------------------------------------------------------------------
;预载
;------------------------------------------------------------------------------------------------------------------------
*载入工程

;假如有最近打开的工程文件夹名记录
[if exp="sf.project!=void"]

	;清理变数
	[clearvar]

	[iscript]

	//假如存在这个工程
	if (checkProject(sf.project)==true)
	{
		//图片预览窗口创建
		if (tf.preview==void) tf.preview=new PicPreviewWindow();

		//载入taglist
		f.taglist=getTagDesc();
		//载入targetlist
		f.target=Scripts.evalStorage("target.tjs");

		//设定Data目录位置
		sf.path=System.exePath + "project/"+sf.project+"/copperlichtdata/";
		sf.outputpath=System.exePath + "project/"+sf.project+"/output/";

		//添加自动搜索路径
		AddPath();
		//载入工程相关设定
		getSetting();
	}
	//假如不存在，删除工程记录并返回开始
	else
	{
		sf.project="";
		kag.process("first.ks","*载入工程");
	}

	[endscript]

[endif]
;------------------------------------------------------------------------------------------------------------------------
;开始描绘菜单
;------------------------------------------------------------------------------------------------------------------------
*window
[iscript]
//描绘背景
with(kag.fore.base)
{
.width=kag.scWidth;
.height=kag.scHeight;
//底板
.fillRect(0,0,kag.scWidth,kag.scHeight,0xFFD4D0C8);

//菜单栏分隔线
.fillRect(0,50,kag.scWidth,1,0xFFaca899);
.fillRect(0,51,kag.scWidth,1,0xFFFFFFFF);

//菜单栏竖线
.fillRect(165+5,5,1,40,0xFFaca899);
.fillRect(290+5,5,1,40,0xFFaca899);
}
[endscript]
;---------------------------------------------------------------
;主菜单
;---------------------------------------------------------------
[rclick enabled="false"]
[history enabled="false" output="false"]
;---------------------------------------------------------------
[current layer="message0"]
[er]
;---------------------------------------------------------------
;创建按钮
[locate x=15 y=10]
[hbutton normal=edit_button_new hint="新建工程：将打开？" storage="first.ks" target=*新建工程]
;[eval exp="drawButtonCaption('新建')"]
[locate x=65 y=10]
[hbutton normal=edit_button_open storage="first.ks" target=*打开工程 hint="打开工程：打开project文件夹下的游戏工程"]
;[eval exp="drawButtonCaption('打开')"]
[locate x=315 y=10]
[hbutton normal=edit_button_help hint="使用说明：查看帮助文件" exp="System.shellExecute( 'https://github.com/Watunder/THE-NVL-Maker/wiki' )" hint="访问教程"]
;[eval exp="drawButtonCaption('教程')"]

[locate x=425 y=10]
[hbutton normal=edit_button_close hint="关闭程序" exp="kag.close()"]
;[eval exp="drawButtonCaption('退出')"]

;组标志
;[locate x=&"kag.scWidth-420" y=5]
;[hbutton normal="?" exp="System.shellExecute( '?' )" hint="?"]
;[locate x=&"kag.scWidth-210" y=5]
;[hbutton normal="?" exp="System.shellExecute( '?' )" hint="?"]
;-------------------------------------------------
;当有工程时才显示
;-------------------------------------------------
[if exp="sf.project!=void"]
[title name=&"'NVLMaker-'+f.setting.title"]
[locate x=115 y=10]
[hbutton normal=edit_button_reload storage="first.ks" target=*载入工程 hint="重载工程：将重载工程相关的设定及素材图片，所有未保存的设定将丢失" exp="f.window=''"]
;[eval exp="drawButtonCaption('重载')"]
[locate x=190 y=10]
[hbutton normal=edit_button_option hint="素材管理：打开游戏工程的素材文件夹，假如添加了新素材，请记得『重载工程』" exp="System.shellExecute(Storages.getLocalName(System.exePath+'/') + '/project/'+sf.project+'/copperlichtdata')"]
;[eval exp="drawButtonCaption('素材')"]
[locate x=240 y=10]
[hbutton normal=edit_button_test storage="first.ks" target=*全篇测试 hint="全篇测试：将从指定的标题文件开始执行游戏"]
;[eval exp="drawButtonCaption('测试')"]
[locate x=370 y=10]
[hbutton normal=edit_button_package storage="first.ks" target=*游戏打包 hint="游戏打包：将打开？"]
;[eval exp="drawButtonCaption('打包')"]
;-------------------------------------------------
;分页按钮
[locate x=10 y=60]
[button normal=edit_button_page storage="project_main.ks" exp="f.window='',sf.main='project_main.ks'"]
[eval exp="drawButtonCaption('工程设定')"]

[locate x=81 y=60]
[button normal=edit_button_page storage="gui_main.ks" exp="f.window='',sf.main='gui_main.ks'"]
[eval exp="drawButtonCaption('界面设定')"]

[locate x=152 y=60]
[button normal=edit_button_page storage="script_main.ks" exp="f.window='',sf.main='script_main.ks'"]
[eval exp="drawButtonCaption('脚本编辑')"]

[locate x=223 y=60]
[button normal=edit_button_page storage="chara_main.ks" exp="f.window='',sf.main='chara_main.ks'"]
[eval exp="drawButtonCaption('姓名编辑')"]

;[locate x=294 y=60]
;[button normal=edit_button_page storage="map_main.ks" exp="f.window='',sf.main='map_main.ks'"]
;[eval exp="drawButtonCaption('游戏系统')"]

;-------------------------------------------------
;默认打开工程设置窗口，但之后会根据之前记录
[jump storage=&"sf.main" cond="sf.main!=void"]
[jump storage="project_main.ks"]
[endif]
[s]

;------------------------------------------------------------------------------------------------------------------------
*打开工程
;------------------------------------------------------------------------------------------------------------------------
;描绘窗口
[window_up width=450 height=400 title="打开工程"]
[iscript]
//工程文件夹的自动路径消去
if (sf.project!=void) RemovePath();

//取得文件夹名+计算页数
getProject();

//默认选中第一项
f.select=0;
//当前窗口
f.window='project';
//描绘按钮
drawButtonLine(20,74,"edit_button_line",10,20);
//描绘BOX
update();
[endscript]

;翻页按钮
[button_page x=345 y=50 length=220]

[s]

*确认
;选择了新的工程或者重载了工程
[if exp="f.project[f.select]!=void"]
[eval exp="sf.project=f.project[f.select]"]
[eval exp="sf.main=''"]
[gotostart ask="false"]
[endif]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[iscript]
if (sf.project!=void)
{
AddPath();
}
[endscript]
[jump target=*window]

;------------------------------------------------------------------------------------------------------------------------
*全篇测试
;------------------------------------------------------------------------------------------------------------------------
;覆写start.ks
[iscript]
rewriteStart(f.setting.startfrom);
//启动测试
runGameTest();
System.inform('不支持的功能');
[endscript]
[jump target=*window]

*游戏打包
;覆写start.ks
[iscript]
rewriteStart(f.setting.startfrom);
//启动软件
runPack();
System.inform('不支持的功能');
[endscript]
[jump target=*window]

*新建工程
;[eval exp="System.shellExecute(Storages.getLocalName(System.exePath)+'Wizard.exe')"]
[eval exp="System.inform('不支持的功能')"]
[jump target=*window]
