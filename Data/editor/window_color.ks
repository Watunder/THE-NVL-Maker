;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------
;颜色转换函数
;------------------------------------------------------------
[iscript]
function drawcolor()
{
//描绘数值
with(kag.fore.layers[7])
{
  //重新描绘一小块区域
  .fillRect(140,40,90,150,0xFFD4D0C8);
  //描绘文字
     .drawText(143,46, f.red, 0x000000);
     .drawText(143,86, f.green, 0x000000);
     .drawText(143,126, f.blue, 0x000000);
  //重新描绘一小块区域
  .fillRect(32,130,90,30,0xFFD4D0C8);
  //描绘文字
  .drawText(32,130, f.color, 0x000000);
}

//设定颜色
var r=d2x(f.red);   while (r.length<2) {r="0"+r;}
var g=d2x(f.green);   while (g.length<2) {g="0"+g;}
var b=d2x(f.blue);   while (b.length<2) {b="0"+b;}

f.color="0x"+r+g+b;

//描绘颜色图
with(kag.fore.layers[8])
{
  .visible=true;
  .width=90;
  .height=90;
  .left=kag.fore.layers[7].left+20;
  .top=kag.fore.layers[7].top+40;
  .colorRect(0,0,90,90,f.color,255);
}

}
[endscript]
;---------------------------------------------------------------
[iscript]
//取得颜色
f.color=(string)(tf.当前编辑值!);
[endscript]
;---------------------------------------------------------------
;颜色选择窗口
;---------------------------------------------------------------
*window
[window_up width=750 height=330 title="选择颜色"]
[iscript]

if (f.color!='')
{
   f.red=x2d(f.color.substring(2,2));
   f.green=x2d(f.color.substring(4,2));
   f.blue=x2d(f.color.substring(6,2));
}
else
{
   f.color="0x000000";
   f.red=0;
   f.green=0;
   f.blue=0;
}

//创建显示用计时器
f.计时器=new Timer(drawcolor, "");
f.计时器.interval = 10;
[endscript]

[locate x=130 y=40]
R    [slider value="f.red" max=255 height=10]
[locate x=130 y=80]
G    [slider value="f.green" max=255 height=10]
[locate x=130 y=120]
B    [slider value="f.blue" max=255 height=10]
[iscript]
f.计时器.enabled=true;
[endscript]
[locate x=430 y=50]
[button normal="edit_colorboard" recthit="false" exp="getdropcolor()" target=*window]
[image layer=10 visible="true" storage="edit_colorboard"]
[layopt layer=10 left=&"(int)kag.fore.messages[7].left+430" top=&"(int)kag.fore.messages[7].top+50"]
[s]

*确认
[eval exp=&"tf.当前编辑值+'=\''+f.color+'\''"]

*关闭选单
[iscript]
f.计时器.enabled=false;
delete f.计时器;
[endscript]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[freeimage layer="10"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
