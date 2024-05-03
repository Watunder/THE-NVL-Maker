;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]
function updateFont()
{
   drawBox("字体",kag.fore.layers[7],20,50,200,15,f.list,f.curpage-1);
   //设定滚动条位置
   with(kag.fore.layers[9])
   {
      .visible=true;
      .top=kag.fore.layers[7].top+66;
      if (f.page>1) .top+=(int)(f.curpage-1)*277/(f.page-1);
   }
   //描绘范例字体
   if (f.list[f.select]!=void) 
       {
              with(kag.fore.layers[8])
               {
                   .visible=true;
                   .width=120;
                   .height=325;
                   .left=kag.fore.layers[7].left+280;
                   .top=kag.fore.layers[7].top+50;
                   .colorRect(0,0,120,325,0xD4D0C8,255);
                   .font.face=f.list[f.select];
                   .font.height=25;
                   .drawText(0,20,"字体样式", 0x000000);
                   .font.height=20;
                   .drawText(0,50,"ABCDEFGHI", 0x000000);
                   .drawText(0,75,"abcdefghi", 0x000000);
                   .drawText(0,100,"1234567890", 0x000000);
                   .font.face="";
                }
        }
}
[endscript]
;---------------------------------------------------------------
;字体选择
;---------------------------------------------------------------
*window
[window_up width=450 height=450 title="选择字体"]
;滚动条
[image layer=9 storage="edit_slider_button" left=&"(int)kag.fore.layers[7].left+225"]
;翻页按钮
[button_page x=225 y=50 length=325]
;滚动条按钮
[button_slider x=225 y=66]
[iscript]
//排列，中文在前
f.list.sort("z");
//计算页数
countPage(f.list.count,15);
//默认显示第一页
f.curpage=1;
//描绘box
f.window='font';
update();

//描绘按钮
drawButtonLine(20,74,"edit_button_line2",15,20);
[endscript]
[s]

*确认
[if exp="f.list[f.select]!=void"]
[eval exp=&"tf.当前编辑值+'=\''+f.list[f.select]+'\''"]
[endif]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[freeimage layer="9"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
