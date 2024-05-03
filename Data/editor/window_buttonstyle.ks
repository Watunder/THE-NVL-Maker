;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;地图据点设定
;--------------------------------------------------
*window
[window_middle width=400 height=450 title="按钮设定"]
[iscript]
drawFrame("按钮图形",3,15,40,kag.fore.layers[5],314);
drawFrame("按钮音效",2,15,175,kag.fore.layers[5],314);
[endscript]

[line title="一般" name="f.参数.normal" x=30 y=60 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=90 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=120 type="pic" path="others" copyfrom="f.参数.over"]

[line title="选中SE" name="f.参数.enterse" x=30 y=190 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=30 y=220 type="sound"]

;;使用文字
;[check title="使用文字" name="f.参数.usetext" x=30 y=205]
;[line title="文字内容" name="f.参数.text" x=30 y=235]
;[line title="字体文件" name="f.参数.fontface" x=30 y=265]
;[line title="字号" name="f.参数.textsize" x=30 y=295]
;[line title="一般颜色" name="f.参数.normalcolor" type="color" x=30 y=325]
;[line title="选中颜色" name="f.参数.overcolor" type="color" x=30 y=355 copyfrom="f.参数.normalcolor"]
;[line title="按下颜色" name="f.参数.oncolor" type="color" x=30 y=385 copyfrom="f.参数.overcolor"]



[s]


*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
