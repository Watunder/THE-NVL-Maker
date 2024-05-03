;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;滚动条样式设定,包括x,y,normal,,button,length几个选项
;--------------------------------------------------
*window
[window_middle width=430 height=570 title="滚动条样式设定"]
[iscript]
drawFrame("位置设定",2,15,40,kag.fore.layers[5],314);
drawFrame("底部设置",5,15,145,kag.fore.layers[5],314);
drawFrame("按钮样式",3,15,345,kag.fore.layers[5],314);

//drawFrame("按钮音效",2,345,40,kag.fore.layers[5],314);
//drawFrame("按钮设置",4,345,145,kag.fore.layers[5],314);
//drawFrame("执行操作",4,345,250,kag.fore.layers[5],314);
[endscript]

[line title="x" name="f.参数.x" x=30 y=60]
[line title="y" name="f.参数.y" x=30 y=90]

[line title="高度" name="f.参数.height" x=30 y=165]
[line title="宽度" name="f.参数.width" x=30 y=195]
[line title="颜色" name="f.参数.color" x=30 y=225 type="color"]
[line title="透明度" name="f.参数.opacity" x=30 y=255]
[line title="图片" name="f.参数.back" x=30 y=285 type="pic" path="others"]

[line title="一般" name="f.参数.normal" x=30 y=365 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=395 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=425 type="pic" path="others" copyfrom="f.参数.over"]

;[line title="选中SE" name="f.参数.enterse" x=360 y=60 type="sound"]
;[line title="按下SE" name="f.参数.clickse" x=360 y=90 type="sound"]

;[line title="高度" name="f.参数.button_h" x=360 y=165]
;[line title="宽度" name="f.参数.button_w" x=360 y=195]
;[line title="颜色" name="f.参数.button_color" x=360 y=225 type="color"]
;[line title="透明度" name="f.参数.button_opacity" x=360 y=255]

[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]


*确认
[commit]
[eval exp=&"tf.当前操作层+'.Reset(f.参数)'"]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
