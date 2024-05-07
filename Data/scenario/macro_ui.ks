;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;常用控件组
;------------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;带有hint的按钮和button
;---------------------------------------------------------------
[macro name="hlink"]
[link * hint=&"getTransStr(mp.hint)"]
[endmacro]
[macro name="hbutton"]
[button * hint=&"getTransStr(mp.hint)"]
[endmacro]
;---------------------------------------------------------------
;指令按钮
;---------------------------------------------------------------
[macro name=button_tag]
[locate x=%x y=%y]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target="*打开指令窗口" exp=%exp]
[eval exp="drawButtonCaption(mp.name)"]
[endmacro]

;---------------------------------------------------------------
;滚动条/翻页按钮
;---------------------------------------------------------------
[macro name=button_page]
[locate x=%x y=%y]
[button normal=edit_slider_up exp="page_up(1)" interval=150 ontimer="page_up(1)"]
[locate x=%x y=&"(int)mp.y+(int)mp.length-16"]
[button normal=edit_slider_down exp="page_down(-1)" interval=150 ontimer="page_down(-1)"]
[endmacro]

[macro name=button_slider]
[locate x=%x y=%y]
[button normal="%normal|edit_slider_back2" interval=10 ontimer="page_scroll()"]
[endmacro]
;---------------------------------------------------------------
;确定取消按钮
;---------------------------------------------------------------
[macro name="uni_okcancel"]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×')"]
[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
[endmacro]
;---------------------------------------------------------------
;下层窗口背景
;---------------------------------------------------------------
[macro name=window_down]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message3"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;中层窗口背景
;---------------------------------------------------------------
[macro name=window_middle]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[5],kag.fore.messages[5],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message5"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;最上层窗口背景
;---------------------------------------------------------------
[macro name=window_up]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;特别设定（图片窗口专用）
;---------------------------------------------------------------
[macro name=window_up_sp]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=close-square-outline target=*关闭选单]
;[eval exp="drawButtonCaption('×')"]
[locate x=93 y=40]
[emb exp="getTransStr('点三角形切换素材文件夹')"]
[locate x=320 y=40]
[emb exp="getTransStr('提示：新加入的素材在预览图中找不到的情况，请“重载工程”后再试')"]
[locate x=&"mp.width-260" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
[endmacro]
;---------------------------------------------------------------
;标题框
;---------------------------------------------------------------
[macro name=frame]
[eval exp="drawFrame(mp.title,(int)mp.line,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;行[type=color/font/music/sound/script/cursor/cond][type=pic附带path/dw/dh]
;---------------------------------------------------------------
[macro name=line]
[eval exp="drawEdit(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.length,mp.true)"]
;附加框1
[if exp="mp.type!=void && mp.type!='pic' && mp.type!='list'"]
[eval exp="drawLink_Win(mp.name,mp.type)"]
[endif]
;图片附加框
[if exp="mp.type=='pic'"]
[eval exp="drawLink_Picwin(mp.name,mp.path,mp.dw,mp.dh)"]
[endif]
;下拉附加框
[if exp="mp.type=='list'"]
[eval exp="drawLink_List(mp.target)"]
[endif]
;附加框2
[if exp="mp.copyfrom!=void"]
 [hlink target=*window exp=&"mp.name+'=copy(\''+mp.copyfrom+'\')'" hint="点此复制上一栏内容"]
〇
[endlink]
[endif]
[endmacro]
;---------------------------------------------------------------
;单选框
;---------------------------------------------------------------
[macro name=check]
[eval exp="drawCheck(mp.title,mp.name,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框
;---------------------------------------------------------------
[macro name=option]
[eval exp="drawOption(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.false)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框组
;---------------------------------------------------------------
[macro name=group]
[eval exp="drawGroup(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.comp)"]
[endmacro]
;---------------------------------------------------------------
;位置联动框(值xy,位置xy,条件,当作范例的图)
;---------------------------------------------------------------
[macro name=pos]
[eval exp="drawPos(mp.valuex,mp.valuey,(int)mp.x,(int)mp.y,mp.true,mp.sample)"]
[endmacro]
;---------------------------------------------------------------
;下拉菜单
;---------------------------------------------------------------
[macro name=list]
[locklink]
[rclick enabled=true jump=true target="%target|*关闭下拉菜单"]
[position layer="%layer|message4" left=&"(int)kag.current.left+(int)mp.x+40" top=&"(int)kag.current.top+(int)mp.y+24"]
[position layer="%layer|message4" width=%width|225 height=&"mp.line*23" frame="" color="0xFFFFFF" opacity=255]
[layopt layer="%layer|message4" visible="true"]
[current layer="%layer|message4"]
[er]
[nowait]
[style align="center"]
[endmacro]

[macro name=list_image_thumlist]
[list x=46 y=40 line=8 layer="message8" width=188]
[link exp="(f.bgimage=loadpic('bgimage') if f.bgimage==void),(f.list=f.bgimage)" target=*关闭下拉菜单][emb exp="getTransStr('背景')"](bgimage)[endlink][r]
[link exp="(f.fgimage=loadpic('fgimage') if f.fgimage==void),(f.list=f.fgimage)" target=*关闭下拉菜单][emb exp="getTransStr('前景')"](fgimage)[endlink][r]
[link exp="(f.rule=loadpic('rule') if f.rule==void),(f.list=f.rule)" target=*关闭下拉菜单][emb exp="getTransStr('遮片')"](rule)[endlink][r]
[link exp="(f.face=loadpic('face') if f.face==void),(f.list=f.face)" target=*关闭下拉菜单][emb exp="getTransStr('头像')"](face)[endlink][r]
[link exp="(f.image=loadpic('image') if f.image==void),(f.list=f.image)" target=*关闭下拉菜单][emb exp="getTransStr('图片')"](image)[endlink][r]
[link exp="(f.others=loadpic('others') if f.others==void),(f.list=f.others)" target=*关闭下拉菜单][emb exp="getTransStr('其他')"](other)[endlink][r]
[link exp="(f.map=loadpic('map') if f.map==void),(f.list=f.map)" target=*关闭下拉菜单][emb exp="getTransStr('地图')"](map)[endlink][r]
[link exp="(f.ui=loadpic('ui') if f.ui==void),(f.list=f.ui)" target=*关闭下拉菜单][emb exp="getTransStr('界面')"](ui)[endlink]
[endmacro]

[return]
