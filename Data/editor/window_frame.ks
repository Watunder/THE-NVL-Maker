;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;对话框设定,包括left,top,frame,margin
;--------------------------------------------------
*window
[iscript]
tf.当前对话框=f.参数.frame;
[endscript]
[window_middle width=400 height=380 title="对话框样式设定"]

[line title="图片" name="f.参数.frame" x=30 y=50 type="pic" path="others"]

[line title="left" name="f.参数.left" x=30 y=80]
[line title="top " name="f.参数.top" x=30 y=110]

[line title="页边距设定" x=30 y=140]
[line title="左" name="f.参数.marginl" x=30 y=170]
[line title="右" name="f.参数.marginr" x=30 y=200]
[line title="上" name="f.参数.margint" x=30 y=230]
[line title="下" name="f.参数.marginb" x=30 y=260] [hlink hint="点此打开边距设定窗口" target=*直接设定]□[endlink]
[s]

*直接设定
[call storage="window_margin.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[iscript]
//为了保证文字正常显示，每次更换对话框图片，则margin会被设置回0
if (tf.当前对话框!=f.参数.frame)
{
	f.参数.marginl=0;
	f.参数.marginr=0;
	f.参数.margint=0;
	f.参数.marginb=0;
}
[endscript]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
