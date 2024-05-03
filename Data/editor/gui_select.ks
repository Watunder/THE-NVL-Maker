;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;选项按钮设定（setting.tjs）
;---------------------------------------------------------------
*window
[window_middle width=700 height=480 title="选项按钮设定"]
[iscript]
drawFrame("按钮图形",3,15,40,kag.fore.layers[5],314);
drawFrame("对齐范围",4,15,175,kag.fore.layers[5],314);
drawFrame("按钮文字",5,345,40,kag.fore.layers[5],314);
drawFrame("按钮音效",2,345,235,kag.fore.layers[5],314);
[endscript]
[line title="一般" name="f.选项按钮.normal" x=30 y=60 type="pic" path="others"]
[line title="选中" name="f.选项按钮.over" x=30 y=90 type="pic" path="others" copyfrom="f.选项按钮.normal"]
[line title="按下" name="f.选项按钮.on" x=30 y=120 type="pic" path="others" copyfrom="f.选项按钮.over"]

[pos valuex="f.选项范围.x" valuey="f.选项范围.y" x=30 y=195]
[line title="宽度" name="f.选项范围.width" x=30 y=255]
[line title="高度" name="f.选项范围.height" x=30 y=285]

[line title="字号" name="f.选项文字.height" x=360 y=60]
[line title="一般" name="f.选项文字.normal" type="color" x=360 y=90]
[line title="选中" name="f.选项文字.over" type="color" x=360 y=120 copyfrom="f.选项文字.normal"]
[line title="按下" name="f.选项文字.on" type="color" x=360 y=150 copyfrom="f.选项文字.over"]
[line title="既读" name="f.选项文字.read" type="color" x=360 y=180 copyfrom="f.选项文字.on"]

[line title="选中SE" name="f.选项按钮.enterse" x=360 y=255 type="sound"]
[line title="按下SE" name="f.选项按钮.clickse" x=360 y=285 type="sound"]
[s]

*确认
[commit]
[iscript]
f.config_sel=%[];
f.config_sel.selbutton=%[];
f.config_sel.selfont=%[];
f.config_sel.scale=%[];
//拷贝编辑过的信息
(Dictionary.assign incontextof f.config_sel.selbutton)(f.选项按钮);
(Dictionary.assign incontextof f.config_sel.selfont)(f.选项文字);
(Dictionary.assign incontextof f.config_sel.scale)(f.选项范围);

//保存选项按钮信息
SaveDic(f.config_sel,"uisel.tjs");
[endscript]

*关闭选单
[rclick enabled="false"]
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]
