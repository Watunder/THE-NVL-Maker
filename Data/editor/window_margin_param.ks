;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;边距设定,包括left,top,frame,margin
;--------------------------------------------------
*window
[window_middle width=400 height=330 title="文字范围设定"]
[iscript]
drawFrame("页边距",4,15,40,kag.fore.layers[5],314);

[endscript]

[line title="左" name="f.参数.marginl" x=30 y=60]
[line title="右" name="f.参数.marginr" x=30 y=90]
[line title="上" name="f.参数.margint" x=30 y=120]
[line title="下" name="f.参数.marginb" x=30 y=150] [link hint="点此打开边距设定窗口" target=*直接设定]□[endlink]
[s]

*直接设定
[call storage="window_margin.ks"]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
