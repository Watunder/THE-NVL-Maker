;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;读取图形样式设定
;--------------------------------------------------
*window
[window_down width=1010 height=700 title="读取图形样式设定"]
;----------------------------------------------
[iscript]
drawFrame("基本设定",2,15,50,kag.fore.layers[3]);
//自动改变数据结构
if (typeof f.config_load.bgd == "String")
{
	var bgdfile=f.config_load.bgd;
	f.config_load.bgd=%["frame"=>bgdfile];
}
[endscript]
[line title="背景" name="f.config_load.bgd.frame" type="pic" path="others" x=30 y=70]
[line title="新档标记" name="f.config_load.lastsavemark" type="pic" path="others" x=30 y=100]

;存档按钮(normal/over/on)
[iscript]
drawFrame("按钮样式设定",5,15,160,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.button.normal" type="pic" path="others" x=30 y=180]
[line title="选中" name="f.config_load.button.over" type="pic" path="others" x=30 y=210 copyfrom="f.config_load.button.normal"]
[line title="按下" name="f.config_load.button.on" type="pic" path="others" x=30 y=240 copyfrom="f.config_load.button.over"]
[line title="选中SE" name="f.config_load.button.enterse" type="sound" x=30 y=270]
[line title="按下SE" name="f.config_load.button.clickse" type="sound" x=30 y=300]

;返回按钮(normal/over/on)
[iscript]
drawFrame("其他按钮",1,345,50,kag.fore.layers[3]);
[endscript]
[locate x=350 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*前一页]
[eval exp="drawButtonCaption('前一页')"]
[locate x=450 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*后一页]
[eval exp="drawButtonCaption('后一页')"]
[locate x=550 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*返回按钮]
[eval exp="drawButtonCaption('返回按钮')"]

[iscript]
drawFrame("标题图",3,15,365,kag.fore.layers[3]);
[endscript]
[line title="图片" name="f.config_load.bgd.stitle" type="pic" path="others" x=30 y=380]
[line title="x" name="f.config_load.bgd.stitle_x" x=30 y=410]
[line title="y" name="f.config_load.bgd.stitle_y" x=30 y=440]

;----------------------------------------------
;按钮文字-档案编号(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-档案编号",2,675,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.num.normal" type="color" x=690 y=60]
[line title="选中" name="f.config_load.num.over" type="color" x=690 y=85 copyfrom="f.config_load.num.normal"]
[line title="按下" name="f.config_load.num.on" type="color" x=690 y=110 copyfrom="f.config_load.num.over"]
;
;章节名称(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-章节名称",2,675,155,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.bookmark.normal" type="color" x=690 y=165]
[line title="选中" name="f.config_load.bookmark.over" type="color" x=690 y=190 copyfrom="f.config_load.bookmark.normal"]
[line title="按下" name="f.config_load.bookmark.on" type="color" x=690 y=215 copyfrom="f.config_load.bookmark.over"]

;存档日期(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-存档日期",2,675,260,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.date.normal" type="color" x=690 y=270]
[line title="选中" name="f.config_load.date.over" type="color" x=690 y=295 copyfrom="f.config_load.date.normal"]
[line title="按下" name="f.config_load.date.on" type="color" x=690 y=320 copyfrom="f.config_load.date.over"]
;
;对话记录(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-对话记录",2,675,365,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_load.history.normal" type="color" x=690 y=375]
[line title="选中" name="f.config_load.history.over" type="color" x=690 y=400 copyfrom="f.config_load.history.normal"]
[line title="按下" name="f.config_load.history.on" type="color" x=690 y=425 copyfrom="f.config_load.history.over"]

;悬停文字(章节/日期/对话)
[iscript]
drawFrame("悬停文字颜色",2,675,475,kag.fore.layers[3]);
[endscript]
[line title="章节名称" name="f.config_load.draw.bookmark" type="color" x=690 y=485]
[line title="存档日期" name="f.config_load.draw.date" type="color" x=690 y=510 copyfrom="f.config_load.draw.bookmark"]
[line title="对话记录" name="f.config_load.draw.talk" type="color" x=690 y=535 copyfrom="f.config_load.draw.bookmark"]
;----------------------------------------------
[s]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]



*前一页
[iscript]
var mydic=%[];
mydic=f.config_load.up;
[endscript]
[jump target=*按钮样式设定]

*后一页
[iscript]
var mydic=%[];
mydic=f.config_load.down;
[endscript]
[jump target=*按钮样式设定]
*返回按钮
[iscript]
var mydic=%[];
mydic=f.config_load.back;
[endscript]
[jump target=*按钮样式设定]

*按钮样式设定
[iscript]
f.参数=%[];
f.参数.normal=mydic.normal;
f.参数.over=mydic.over;
f.参数.on=mydic.on;
f.参数.enterse=mydic.enterse;
f.参数.clickse=mydic.clickse;

f.参数.usetext=mydic.usetext;
f.参数.text=mydic.text;
f.参数.fontface=mydic.fontface;
f.参数.textsize=mydic.textsize;

f.参数.normalcolor=mydic.normalcolor;
f.参数.overcolor=mydic.overcolor;
f.参数.oncolor=mydic.oncolor;
[endscript]

[call storage="window_buttonstyle.ks"]

[iscript]

mydic.normal=f.参数.normal;
mydic.over=f.参数.over;
mydic.on=f.参数.on;
mydic.enterse=f.参数.enterse;
mydic.clickse=f.参数.clickse;

mydic.usetext=f.参数.usetext;
mydic.text=f.参数.text;
mydic.fontface=f.参数.fontface;
mydic.textsize=f.参数.textsize;
mydic.normalcolor=f.参数.normalcolor;
mydic.overcolor=f.参数.overcolor;
mydic.oncolor=f.参数.oncolor;

mydic=%[];

[endscript]
[jump target=*window]

*确认
;保存当前f.config_load
[commit]
[iscript]
SaveDic(f.config_load,"uiload.tjs");
[endscript]

*关闭选单
;重载f.config_load
[iscript]
f.config_load=LoadDic("uiload.tjs");
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
