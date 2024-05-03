;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------

;---------------------------------------------------------------
;背景设定
;---------------------------------------------------------------
*window
[window_middle width=400 height=350 title="背景设定"]
[iscript]
drawFrame("背景图",1,15,40,kag.fore.layers[5],314);
drawFrame("标题图",3,15,115,kag.fore.layers[5],314);

[endscript]

[line title="背景图" name="f.参数.frame" x=30 y=60 type="pic" path="ui"]
[line title="图片" name="f.参数.stitle" x=30 y=130 type="pic" path="ui"]
[line title="x" name="f.参数.stitle_x" x=30 y=160]
[line title="y" name="f.参数.stitle_y" x=30 y=190]

[s]


*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]


*选择文件
[call storage="window_file.ks"]
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
