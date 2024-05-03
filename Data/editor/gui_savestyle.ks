;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;存储图形样式设定
;--------------------------------------------------
*window
[window_down width=1010 height=700 title="存储图形样式设定"]
;----------------------------------------------
[iscript]
drawFrame("基本设定",2,15,50,kag.fore.layers[3]);
//自动改变数据结构
if (typeof f.config_save.bgd == "String")
{
	var bgdfile=f.config_save.bgd;
	f.config_save.bgd=%["frame"=>bgdfile];
}
[endscript]
[line title="背景" name="f.config_save.bgd.frame" type="pic" path="others" x=30 y=70]
[line title="新档标记" name="f.config_save.lastsavemark" type="pic" path="others" x=30 y=100]

;存档按钮(normal/over/on)
[iscript]
drawFrame("按钮样式设定",5,15,160,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.button.normal" type="pic" path="others" x=30 y=180]
[line title="选中" name="f.config_save.button.over" type="pic" path="others" x=30 y=210 copyfrom="f.config_save.button.normal"]
[line title="按下" name="f.config_save.button.on" type="pic" path="others" x=30 y=240 copyfrom="f.config_save.button.over"]
[line title="选中SE" name="f.config_save.button.enterse" type="sound" x=30 y=270]
[line title="按下SE" name="f.config_save.button.clickse" type="sound" x=30 y=300]

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
[line title="图片" name="f.config_save.bgd.stitle" type="pic" path="others" x=30 y=380]
[line title="x" name="f.config_save.bgd.stitle_x" x=30 y=410]
[line title="y" name="f.config_save.bgd.stitle_y" x=30 y=440]

;----------------------------------------------
;按钮文字-档案编号(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-档案编号",2,675,50,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.num.normal" type="color" x=690 y=60]
[line title="选中" name="f.config_save.num.over" type="color" x=690 y=85 copyfrom="f.config_save.num.normal"]
[line title="按下" name="f.config_save.num.on" type="color" x=690 y=110 copyfrom="f.config_save.num.over"]
;
;章节名称(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-章节名称",2,675,155,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.bookmark.normal" type="color" x=690 y=165]
[line title="选中" name="f.config_save.bookmark.over" type="color" x=690 y=190 copyfrom="f.config_save.bookmark.normal"]
[line title="按下" name="f.config_save.bookmark.on" type="color" x=690 y=215 copyfrom="f.config_save.bookmark.over"]

;存档日期(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-存档日期",2,675,260,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.date.normal" type="color" x=690 y=270]
[line title="选中" name="f.config_save.date.over" type="color" x=690 y=295 copyfrom="f.config_save.date.normal"]
[line title="按下" name="f.config_save.date.on" type="color" x=690 y=320 copyfrom="f.config_save.date.over"]
;
;对话记录(normal/over/on)
[iscript]
drawFrame("按钮文字颜色-对话记录",2,675,365,kag.fore.layers[3]);
[endscript]
[line title="一般" name="f.config_save.history.normal" type="color" x=690 y=375]
[line title="选中" name="f.config_save.history.over" type="color" x=690 y=400 copyfrom="f.config_save.history.normal"]
[line title="按下" name="f.config_save.history.on" type="color" x=690 y=425 copyfrom="f.config_save.history.over"]

;悬停文字(章节/日期/对话)
[iscript]
drawFrame("悬停文字颜色",2,675,475,kag.fore.layers[3]);
[endscript]
[line title="章节名称" name="f.config_save.draw.bookmark" type="color" x=690 y=485]
[line title="存档日期" name="f.config_save.draw.date" type="color" x=690 y=510 copyfrom="f.config_save.draw.bookmark"]
[line title="对话记录" name="f.config_save.draw.talk" type="color" x=690 y=535 copyfrom="f.config_save.draw.bookmark"]
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
mydic=f.config_save.up;
[endscript]
[jump target=*按钮样式设定]

*后一页
[iscript]
var mydic=%[];
mydic=f.config_save.down;
[endscript]
[jump target=*按钮样式设定]
*返回按钮
[iscript]
var mydic=%[];
mydic=f.config_save.back;
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
;保存当前f.config_save
[commit]
[iscript]
SaveDic(f.config_save,"uisave.tjs");
[endscript]

*关闭选单
;重载f.config_save
[iscript]
f.config_save=LoadDic("uisave.tjs");
[endscript]

[rclick enabled="false"]
[freeimage layer="3"]
[freeimage layer="4"]
[current layer="message3"]
[er]
[layopt layer="message3" visible="false"]
[jump storage="gui_main.ks"]
