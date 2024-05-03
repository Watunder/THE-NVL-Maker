;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;滑动槽设定,包括x,y,base,normal,over,on几个选项
;--------------------------------------------------
*window
[window_middle width=400 height=400 title="滑动槽样式设定"]
[line title="位置" x=30 y=50]
[line title="x" name="f.参数.x" x=30 y=80]
[line title="y" name="f.参数.y" x=30 y=110]
[line title="底图" name="f.参数.base" x=30 y=150 type="pic" path="others"]
[line title="滑动按钮" x=30 y=190]
[line title="一般" name="f.参数.normal" x=30 y=220 type="pic" path="others"]
[line title="选中" name="f.参数.over" x=30 y=250 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="按下" name="f.参数.on" x=30 y=280 type="pic" path="others" copyfrom="f.参数.over"]
[s]

*选择图片
[call storage="window_picture.ks"]
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
