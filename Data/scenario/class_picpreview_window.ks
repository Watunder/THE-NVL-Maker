;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------
;图片预览窗口
;---------------------------------------
*start
[iscript]
class PicPreviewWindow extends Window
{
  
  var piclayer;
  
  var menu_sop;
  var menu_pre;
  var menu_next;
  
  function PicPreviewWindow()
  {
    super.Window();
    add(new Layer(this, null));
    primaryLayer.setSize(240+20, 180+62);
    piclayer= new Layer(this, primaryLayer);
    //设定初始值
    setInnerSize(primaryLayer.width, primaryLayer.height);
    caption = "图片预览窗口";
    setPos(0,0);
    showScrollBars=true;
    // ［ファイル］メニューを作成
    menu_sop = new MenuItem(this, "总在最前");
    menu.add(menu_sop);
    
    menu_pre = new MenuItem(this, "上一张");
    menu_next = new MenuItem(this, "下一张");
    menu.add(menu_pre);
    menu.add(menu_next);
  }
  
//载入图片
 function getPicture(pic="empty")
 {
    with(piclayer)
    {
      .visible=true;
      .loadImages(pic);
      .setSizeToImageSize();
    }
    primaryLayer.setSize(piclayer.width, piclayer.height);
	
	var window_width=240+20;
	var window_height=180+62;
	if (primaryLayer.width>240) window_width=primaryLayer.width+20;
	if (primaryLayer.height>180) window_height=primaryLayer.height+62;
	
	this.setSize(window_width,window_height);
	
    caption=pic;
    visible=true;
 }
//隐藏窗口
 function hideWindow()
 {
    visible=false;
 }
 
  function finalize()
  {
    super.Window();
  }
  function showpre()
  {
    if (f.select-1>=0)
    {
       f.select--;
       if (f.select<(f.curpage-1)*15) page_up();
       global.update();
       getPicture(f.list[f.select].name);
    }
  }
  function shownext()
  {
    if (f.select+1<f.list.count)
    {
       f.select++;
       if (f.select>=f.curpage*15) page_down();
       global.update();
       getPicture(f.list[f.select].name);
    }
  }
//事件
  function action(ev)

  {
    switch (ev.target) 
    {
    //总在最前
    case menu_sop:
      stayOnTop=!stayOnTop;
      break;
    //选择上一张
    case menu_pre:
      showpre();
      break;
    //选择下一张
    case menu_next:
      shownext();
      break;
    }
  }

}
[endscript]
;---------------------------------------
[return]
