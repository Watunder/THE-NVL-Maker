;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;开关样式设定,包括x,y,normal,over,on,on_over几个选项
;--------------------------------------------------
*window
[window_middle width=700 height=450 title="开关样式设定"]
[iscript]
drawFrame("显示设定",1,15,40,kag.fore.layers[5],314);
drawFrame("按钮图形",6,15,115,kag.fore.layers[5],314);
//drawFrame("按钮文字",10,15,345,kag.fore.layers[5],314);

drawFrame("按钮音效",2,345,40,kag.fore.layers[5],314);
[endscript]

[check title="使用" name="f.参数.use" x=30 y=60]

[line title="x" name="f.参数.x" x=30 y=135]
[line title="y" name="f.参数.y" x=30 y=165]
[line title="OFF：一般" name="f.参数.normal" x=30 y=195 type="pic" path="others"]
[line title="OFF：选中" name="f.参数.over" x=30 y=225 type="pic" path="others" copyfrom="f.参数.normal"]
[line title="ON：一般" name="f.参数.on" x=30 y=255 type="pic" path="others" copyfrom="f.参数.over"]
[line title="ON：选中" name="f.参数.on_over" x=30 y=285 type="pic" path="others" copyfrom="f.参数.over"]

;;使用文字
;[check title="使用文字" name="f.参数.usetext" x=30 y=365]
;[if exp="f.参数.usetext"]
;[line title="文字内容" name="f.参数.text" x=30 y=395]
;[line title="字体文件" name="f.参数.fontface" x=30 y=425]
;[line title="字号" name="f.参数.textsize" x=30 y=455]
;[line title="一般颜色" name="f.参数.normalcolor" type="color" x=30 y=485]
;[line title="选中颜色" name="f.参数.overcolor" type="color" x=30 y=515 copyfrom="f.参数.normalcolor"]
;[line title="按下颜色" name="f.参数.oncolor" type="color" x=30 y=545 copyfrom="f.参数.overcolor"]
;
;[line title="x" name="f.参数.text_offx" x=30 y=580]
;[line title="y" name="f.参数.text_offy" x=30 y=610]
;[line title="字符串" name="f.参数.text_uistring" x=30 y=640]
;
;[endif]
;
;;使用图标
;[check title="使用图标" name="f.参数.useicon" x=160 y=365]
;[if exp="f.参数.useicon && f.参数.usetext==false"]
;[line title="x" name="f.参数.icon_x" x=30 y=395]
;[line title="y" name="f.参数.icon_y" x=30 y=425]
;[line title="一般" name="f.参数.icon_normal" type="pic" path="others" x=30 y=485]
;[line title="选中" name="f.参数.icon_over" type="pic" path="others" x=30 y=515 copyfrom="f.参数.icon_normal"]
;[line title="按下" name="f.参数.icon_on" type="pic" path="others" x=30 y=545 copyfrom="f.参数.icon_over"]
;[endif]

[line title="选中SE" name="f.参数.enterse" x=360 y=60 type="sound"]
[line title="按下SE" name="f.参数.clickse" x=360 y=90 type="sound"]
[s]
*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

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
