;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;系统按钮设定,包括x,y,normal,over,on几个选项
;--------------------------------------------------
*window
[window_middle width=400 height=500 title="系统按钮样式设定"]
[iscript]
drawFrame("按钮图形",3,15,40,kag.fore.layers[5],314);
drawFrame("按钮音效",2,15,175,kag.fore.layers[5],314);
drawFrame("坐标",2,15,280,kag.fore.layers[5],314);
[endscript]

[line title="一般" name="f.参数.normal" x=30 y=60 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=90 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=120 type="pic" path="others" copyfrom="f.参数.over"]

[line title="选中SE" name="f.参数.enterse" x=30 y=190 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=30 y=220 type="sound"]

[line title="x" name="f.参数.x" x=30 y=295]
[line title="y" name="f.参数.y" x=30 y=325]
[s]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
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
