;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;列表设定
;--------------------------------------------------
*window
[window_middle width=700 height=470 title="列表设定"]
[iscript]
drawFrame("文字设定",6,15,40,kag.fore.layers[5],314);
drawFrame("列表排版",4,15,265,kag.fore.layers[5],314);

drawFrame("文字位置（相对按钮）",2,345,40,kag.fore.layers[5],314);
drawFrame("按钮图形",3,345,145,kag.fore.layers[5],314);

drawFrame("列表坐标",2,345,280,kag.fore.layers[5],314);
//drawFrame("执行操作",3,345,250,kag.fore.layers[5],314);
[endscript]

[check title="加粗" name="f.参数.bold" x=30 y=60]
[check title="斜体" name="f.参数.italic" x=130 y=60]

[option title="阴影" name="f.参数.shadow" x=30 y=90 false="f.参数.edge"]

[line title="" name="f.参数.shadowcolor" type="color" x=80 y=90 true="f.参数.shadow" length=174]
[option title="边缘" name="f.参数.edge" x=30 y=120 false="f.参数.shadow"]
[line title="" name="f.参数.edgecolor" type="color" x=80 y=120 true="f.参数.edge" length=174]

[line title="字体" name="f.参数.face" x=30 y=150 type="font"]
[line title="字号" name="f.参数.size" x=30 y=180]
[line title="颜色" name="f.参数.color" x=30 y=210 type=color]

[line title="一般" name="f.参数.normal" x=360 y=160 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=360 y=190 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=360 y=220 type="pic" path="others" copyfrom="f.参数.over"]

[line title="x" name="f.参数.x" x=360 y=60]
[line title="y" name="f.参数.y" x=360 y=90]

[line title="每页元素" name="f.参数.num" x=30 y=280]
[line title="行间距" name="f.参数.disy" x=30 y=310]

[group title="单列" name="f.参数.line" x=30 y=340 comp="single"]
[group title="双列" name="f.参数.line" x=130 y=340 comp="double"]
[if exp="f.参数.line=='double'"]
[line title="列间距" name="f.参数.disx" x=30 y=370]
[endif]

;控件坐标
[pos valuex="f.参数.left" valuey="f.参数.top" x=360 y=300]
[s]

*生成条件
[call storage="window_cond.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
