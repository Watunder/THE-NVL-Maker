;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;UI背景板描绘
;------------------------------------------------------------------------------------------------
[iscript]
function drawUIEditorBack(x=20,y=50)
{

	   kag.fore.layers[3].fillRect(x,y,sf.gs.width,sf.gs.height,0xFFC8C8C8);

		//背景重载
		with(kag.fore.layers[4])
		{
			.left=kag.fore.layers[3].left+x;
			.top=kag.fore.layers[3].top+y;
			.visible=true;
			.width=sf.gs.width;
			.height=sf.gs.height;
			.fillRect(0,0,sf.gs.width,sf.gs.height,0xFFC8C8C8);
		}
}
[endscript]
;------------------------------------------------------------------------------------------------
;UI背景板描绘
;------------------------------------------------------------------------------------------------
[iscript]
function deleteUILayers()
{
	delete tf.当前操作层;
	delete f.uilayer;
	delete f.uibacklayer;
}
[endscript]
;------------------------------------------------------------------------------------------------
;颜色相关处理函数
;------------------------------------------------------------------------------------------------
[iscript]
//滴管取色
function getdropcolor()
{
  //取得颜色
   var color=kag.fore.layers[10].getMainPixel(kag.fore.layers[10].cursorX,kag.fore.layers[10].cursorY);
  //转换为16进制
   color=d2x(color);
   while (color.length<6) {color="0"+color;}
   f.color="0x"+color;
}
[endscript]

[iscript]
//十进制->十六进制转换
function d2x(num)
{
        var CH = "0123456789ABCDEF";
        var res = "";
        while (num>=1)
        {
                res = CH[num % 16] + res;
                num /= 16;
        }
        return res;
}
//十六进制->十进制转换
function x2d(str)
{
       var res=(int)("0x"+str);
       return res;
}
[endscript]
;------------------------------------------------------------------------------------------------
;滚动条的描绘
;------------------------------------------------------------------------------------------------
[iscript]
function updateFile()
{
   drawBox("文件",kag.fore.layers[7],20,50,200,15,f.list,f.curpage-1);
   //设定滚动条位置
   with(kag.fore.layers[9])
   {
      .visible=true;
      .top=kag.fore.layers[7].top+66;
      if (f.page>1) .top+=(int)(f.curpage-1)*277/(f.page-1);
   }
}
[endscript]
;-----------------------------------------------------------------------------------------------
;通用的翻页刷新操作
;-----------------------------------------------------------------------------------------------
[iscript]
//通用翻页上
function page_up(scale)
{
    if (f.window!='' && f.window!='script')
    {
      if (f.curpage>1) f.curpage--;
      update();
    }
    else if (f.window=='script')
    {
      while (scale>0) {line_up();scale--;}
      updateScript();
    }
}
//-----------------------------------------------------------------------------------------------
//通用翻页下
function page_down(scale)
{
    if (f.window!='' && f.window!='script')
    {
      if (f.curpage<f.page) f.curpage++;
      update();
    }
        else if (f.window=='script')
    {
      while (scale<0) {line_down();scale++;}
      updateScript();
    }
}
//-----------------------------------------------------------------------------------------------
//一般计算页数
function countPage(count,line)
{
   //计算页数
   f.page=count\line;
   if (count%line>0) f.page++;
   //默认翻到最后一页
   f.curpage=f.page;   
   //默认不选中
   f.select=count;
}
//-----------------------------------------------------------------------------------------------
//一般选择一行
function setselect(num,line)
{
	//未选择
	if (f.select!=num+line*(f.curpage-1))
	{
		f.select=num+line*(f.curpage-1);
		update();
	}
	else
	{
		//假如已选择,且为图片窗口，显示图片预览窗口
		if (f.window=="picture" && f.list[f.select]!=void)
		tf.preview.getPicture(f.list[f.select].name);
	}
}

//-----------------------------------------------------------------------------------------------
//一般拖动
function page_scroll()
{
     if (kag.fore.base.cursorY<kag.fore.layers[9].top) page_up();
     if (kag.fore.base.cursorY>(int)kag.fore.layers[9].top+(int)kag.fore.layers[9].height) page_down();
}
//-----------------------------------------------------------------------------------------------
//一般描绘
function update()
{
    switch(f.window)
    {
       //为选择工程窗口的情况
        case "project":
                drawBox("文件夹",kag.fore.layers[7],20,50,150,10,f.project,f.curpage-1);
                drawBox("名称",kag.fore.layers[7],169,50,170,10,f.title,f.curpage-1);
                break;
       //为选择字体窗口的情况
        case "font":
                updateFont();
                break;
       //为一般文件选择
        case "file":
                updateFile();
                break;
        //为图片
        case "picture":
                updatePicture();
                break;
    }
}
[endscript]
;------------------------------------------------------------------------------------------------
;很少用的描绘组
;------------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;描绘按钮
;---------------------------------------------------------------
[iscript]
function drawButtonCaption(caption,size=16)
{
	var button=kag.current.links[kag.current.links.count-1].object;

	caption=getTransStr(caption);

	button.font.height = size;     //文字大小设定

	//button.font.face = "宋体"; //改字体的地方
	button.font.mapPrerenderedFont("font_16.tft");

	var w = button.font.getTextWidth(caption); // 取得要描绘文字的宽度
	var x = (button.width - w) \ 2;    // 在按钮中央显示文字
	var y = (button.height - size) \ 2-1;   //   文字在按钮上的y位置（左上角起算）
	var color=0x000000;
	var edge=0xFFFFFF;
	// 按钮「通常状態」部分文字显示
	button.drawText(x,                           y, caption, color,255,true,255,edge,1,0,0);
	// 按钮「按下状態」部分文字显示
	button.drawText(x+button.width,              y, caption, color,255,true,255,edge,1,0,0);
	// 按钮「选中状態」部分文字显示
	button.drawText(x+button.width+button.width, y, caption, color,255,true,255,edge,1,0,0);
}
[endscript]

;--------------------------------------------------------------
;主界面页背景
;--------------------------------------------------------------
[iscript]
function drawPageBoard(x=1)
{

var w=kag.scWidth-25;
var h=kag.scHeight-95;
 //底板
  with(kag.fore.layers[0])
  {
     .visible=true;
     .left=10;
     .top=81;
     .width=w;
     .height=h;
     //底板
     .fillRect(0,0,w,h,0xFFD4D0C8);
     //.fillRect(0,0,1400,610,0xFFD4D0C8);
     //描边
     .fillRect(0,0,w,1,0xFFFFFFFF);
     .fillRect(0,0,1,h,0xFFaca899);
     .fillRect(1,0,1,h,0xFFFFFFFF);
     .fillRect(0,h-1,w,1,0xFFaca899);
     .fillRect(w-1,0,1,h,0xFFaca899);
     //当前显示第几页，补描绘按钮下空白
     .fillRect(x,0,68,1,0xFFD4D0C8);
  }
  //编辑器界面
  with(kag.fore.messages[1])
  {
     .visible=true;
     .left=10;
     .top=81;
     .width=w;
     .height=h;
  }
}
[endscript]

;--------------------------------------------------------------
;TAG页背景
;--------------------------------------------------------------
[iscript]
function drawTagBoard(x=2,a=15,b=251,w=610,h=210)
{
 //底板
  with(kag.fore.layers[3])
  {
     //底板
     .fillRect(a,b,w,h,0xFFD4D0C8);
     //描边
     .fillRect(a,b,w,1,0xFFFFFFFF);//横1
     .fillRect(a,b,1,h,0xFFaca899);//纵1
     .fillRect(a+1,b,1,h,0xFFFFFFFF);//纵2
     .fillRect(a,b+h-1,w,1,0xFFaca899);//横阴影
     .fillRect(a+w-1,b,1,h,0xFFaca899);//纵阴影
    //当前显示第几页，补描绘按钮下空白
     .fillRect(a+x,b,68,1,0xFFD4D0C8);
  }
}
[endscript]
;--------------------------------------------------------------
;功能分隔栏
;--------------------------------------------------------------
[iscript]
function drawFrame(title,line=7,x=15,y=15,layer=kag.fore.layers[0],width=314)
{
	var height=(line+1)*30;

	title=getTransStr(title);

  with(layer)
  {
	//.font.face = "宋体"; //改字体的地方
	.font.height=16;
	.font.mapPrerenderedFont("font_16.tft");

  //上
      .fillRect(x,y,width,1,0xFFaca899);
      .fillRect(x,y+1,width,1,0xFFFFFFFF);
  //下
      .fillRect(x,y+height,width+1,1,0xFFaca899);
      .fillRect(x,y+height+1,width+2,1,0xFFFFFFFF);
  //左
      .fillRect(x,y,1,height,0xFFaca899);
      .fillRect(x+1,y+1,1,height-1,0xFFFFFFFF);
  //右
      .fillRect(x+width,y,1,height+1,0xFFaca899);
      .fillRect(x+width+1,y,1,height+1,0xFFFFFFFF);
  //标题描绘区域
      .fillRect(x+10,y,layer.font.getTextWidth(title)+10,1,0xFFD4D0C8);
      .fillRect(x+10,y+1,layer.font.getTextWidth(title)+10,1,0xFFD4D0C8);
  //文字
      .drawText(x+15,y-6, title, 0x000000);
  }
}
[endscript]
;--------------------------------------------------------------
;坐标栏
;--------------------------------------------------------------
[iscript]
function DrawPosFrame(x=40,y=50)
{
	//描绘坐标框
	drawFrame("当前坐标",1,sf.gs.width+x,y,kag.fore.layers[3],140);

	//描绘批量调整位置按钮
/*
     kag.tagHandlers.locate(
     %[
         "x"=>sf.gs.width+x+2,
         "y"=>y+20
      ]
      );
      var setting=new Dictionary();
      setting.normal="edit_button_copy";
      setting.target="*调整位置";
      
      kag.tagHandlers.button(setting);
*/
}
[endscript]
;------------------------------------------------------------------------------------------------
;常用控件组
;------------------------------------------------------------------------------------------------
[iscript]
//--------------------------------------------------------------
//参数复制函数
//--------------------------------------------------------------
function copy(value)
{
kag.current.commit();
return value!;
}
//--------------------------------------------------------------
//基本edit框描绘[标题,处理值,位置,条件]
//--------------------------------------------------------------
function drawEdit(title,value,posX,posY,length=224,cond='')
{

	title=getTransStr(title);

  //描绘提示文字

  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  
  var width=kag.current.font.getTextWidth(title);
  kag.tagHandlers.locate(%["x"=>posX+width+20,"y"=>posY]);
  
  if (value!=void)
  {
      //描绘编辑框
      var result=cond!;
      var setting=new Dictionary();
      setting.name=value;
      setting.length=length-width;
       //值为伪时，设定特殊颜色
       if (result==false && cond!=void)
       {
            setting.bgcolor=0xD4D0C8;
            setting.color=0xD4D0C8;
        }
       kag.tagHandlers.edit(setting);
  }
}
//--------------------------------------------------------------
//附加连接框□的描绘、图片选择窗口[处理值，路径，联动宽高]
//--------------------------------------------------------------
function drawLink_Picwin(value,path,withwidth='',withheight='')
{
   //空格
   kag.tagHandlers.ch(%["text"=>" "]);
   //连接
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.当前编辑值=\'"+value+"\'";
   setting.hint=getTransStr("点此打开图片选择窗口");
   setting.target="*选择图片";
   //根据路径,传入必须参数
   if (Scripts.eval("f."+path)==void) Scripts.eval("f."+path+"=loadpic("+"'"+path+"')");
   setting.exp+=",f.list=f."+path;
   kag.tagHandlers.link(setting);
   //方块
   kag.tagHandlers.ch(%["text"=>"□"]);
   kag.tagHandlers.endlink(%[]);
}

//--------------------------------------------------------------
//附加连接框□的描绘、图片以外[处理值，打开的窗口类型(扩展名,路径无法更改)]
//--------------------------------------------------------------
function drawLink_Win(value,type)
{
   //空格
   kag.tagHandlers.ch(%["text"=>" "]);
   //连接
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.当前编辑值=\'"+value+"\'";
   //根据文件类型进行设定
   switch (type)
   {
      //选择颜色
      case "color":
           setting.hint=getTransStr("点此打开颜色选择窗口");
           setting.target="*选择颜色";
           break;
      //选择字体文件（范例文字）
      case "font":
           setting.exp+=",f.list=kag.fore.base.font.getList(fsfNoVertical)";
           setting.hint=getTransStr("点此打开字体选择窗口");
           setting.target="*选择字体";
           break;
     //音乐音效
      case "music":
           setting.exp+=",f.list=getsozai('bgm','bgm')";
           setting.hint=getTransStr("点此打开音乐选择窗口");
           setting.target="*选择音声";
           break;
      case "sound":
           setting.exp+=",f.list=getsozai('se','sound')";
           setting.hint=getTransStr("点此打开音效选择窗口");
           setting.target="*选择音声";
           break;
      case "voice":
           setting.exp+=",f.list=getsozai('se','voice')";
           setting.hint=getTransStr("点此打开语音选择窗口");
           setting.target="*选择音声";
           break;
      case "video":
           setting.exp+=",f.list=getsozai('mv','video')";
           setting.hint=getTransStr("点此打开视频选择窗口");
           setting.target="*选择音声";
           break;
      //选择剧本类文件
      case "script":
           setting.exp+=",f.list=getsozai('story','scenario')";
           setting.hint=getTransStr("点此打开剧本选择窗口");
           setting.target="*选择文件";
           break;
		//选择标题类文件
      case "title":
           setting.exp+=",f.list=getsozai('title','nvl')";
           setting.hint=getTransStr("点此打开标题选择窗口");
           setting.target="*选择文件";
           break;
       //选择鼠标类文件
       case "cursor":
           setting.exp+=",f.list=getsozai('cur','others')";
           setting.hint=getTransStr("点此打开鼠标文件选择窗口");
           setting.target="*选择文件";
           break;
      //姓名编辑器
       case "name":
           setting.hint=getTransStr("点此打开姓名详细编辑窗口");
           setting.target="*编辑姓名";
           break;
      //选择地图
       case "map":
           setting.exp+=",f.list=getsozai('map','map')";
           setting.hint=getTransStr("点此打开地图文件选择窗口");
           setting.target="*选择文件";
           break;
       //选择养成面板
       case "edu":
           setting.exp+=",f.list=getsozai('edu','map')";
           setting.hint=getTransStr("点此打开养成面板文件选择窗口");
           setting.target="*选择文件";
           break;
       //生成tjs式
       case "cond":
           setting.hint=getTransStr("点此打开TJS条件式生成器");
           setting.target="*生成条件";
           break;
   }
   kag.tagHandlers.link(setting);
   //方块
   kag.tagHandlers.ch(%["text"=>"□"]);
   kag.tagHandlers.endlink(%[]);
}
//--------------------------------------------------------------
//附加连接框▽的描绘[转到的菜单target]
//--------------------------------------------------------------
function drawLink_List(target)
{
       //描绘下拉菜单
       kag.tagHandlers.ch(%["text"=>" "]);
       kag.tagHandlers.link(%[
       "hint"=>"点此打开下拉菜单",
       "target"=>target
       ]);
       kag.tagHandlers.ch(%["text"=>"▽"]);
       kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘-位置行
;--------------------------------------------------------------
[iscript]
function drawPos(valueX,valueY,posX,posY,cond='',sample='')
{
    //描绘提示文字
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>"x"]);
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+30]);
  kag.tagHandlers.ch(%["text"=>"y"]);
  var result=cond!;
  if (cond==void || result==true)
  {
  //x
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY]);
       kag.tagHandlers.edit(%["name"=>valueX]);
  //y
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY+30]);
       kag.tagHandlers.edit(%["name"=>valueY]);
  //link
//       kag.tagHandlers.ch(%["text"=>" "]);
//       kag.tagHandlers.link(%[
//       "hint"=>"点此打开位置设定窗口"
//       ]);
//       kag.tagHandlers.ch(%["text"=>"□"]);
//       kag.tagHandlers.endlink(%[]);
    }
    else if (result==false)
    {
  //x
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY]);
       kag.tagHandlers.edit(%["name"=>valueX,"bgcolor"=>0xD4D0C8,"color"=>0xD4D0C8]);
  //y
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY+30]);
       kag.tagHandlers.edit(%["name"=>valueY,"bgcolor"=>0xD4D0C8,"color"=>0xD4D0C8]);
  //link
//       kag.tagHandlers.ch(%["text"=>" "]);
//       kag.tagHandlers.link(%[
//       "hint"=>"点此打开位置设定窗口"
//       ]);
//       kag.tagHandlers.ch(%["text"=>"□"]);
//       kag.tagHandlers.endlink(%[]);
    }
}
[endscript]
;--------------------------------------------------------------
;特殊描绘-独立选框
;--------------------------------------------------------------
[iscript]
function drawCheck(title,value,posX,posY)
{

	title=getTransStr(title);

  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+6]);
  //取得值
  var result=value!;
  //值为空(默认)
    if (result===void)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_void",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值为真
  else if (result==true || result=="true")
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_over",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值为假
  else if (result==false || result=="false")
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_normal",
    "exp"=>"kag.current.commit(),"+value+"=true",
    "target"=>"*window"
    ]);
  }
  //描绘提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘-互斥选框(A值为T,则B值强制为F)
;--------------------------------------------------------------
[iscript]
function drawOption(title,value,posX,posY,negvalue)
{

	title=getTransStr(title);

  //描绘提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+5]);
  //取得值
  var result=value!;
  //值为真
  if (result==true)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_over",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值为假
  else if (result==false)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_normal",
    "exp"=>"kag.current.commit(),"+value+"=true,"+negvalue+"=false",
    "target"=>"*window"
    ]);
  }

}
[endscript]
;--------------------------------------------------------------
;特殊描绘-互斥选框2(比较值A和B)
;--------------------------------------------------------------
[iscript]
function drawGroup(title,value,posX,posY,comp)
{

	title=getTransStr(title);

//value=变数名
//comp=默认值
//当两值相等时为真
  //描绘提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+5]);
  //取得值
  var result=value!;
  
  if (result==comp)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_over",
    "exp"=>"kag.current.commit(),"+value+"='"+comp+"'",
    "target"=>"*window"
    ]);
  }
  else if (result!=comp)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_normal",
    "exp"=>"kag.current.commit(),"+value+"='"+comp+"'",
    "target"=>"*window"
    ]);
  }
  
}
[endscript]
;---------------------------------------------------------------
;描绘基本窗口
;---------------------------------------------------------------
[iscript]
function drawWin(layer,message,title,width,height)
{

	title=getTransStr(title);

    with(layer)
  {
     .visible=true;
     .left=(kag.scWidth-width)/2;
     .top=(kag.scHeight-height)/2;
     if (.top>=10) .top=10;
     .width=width;
     .height=height;
     //底板
     .fillRect(0,0,width,height,0xFFD4D0C8);
     .fillRect(0,0,width,1,0xFFFFFFFF);
     .fillRect(0,0,1,height,0xFFFFFFFF);
     .fillRect(0,height-1,width,1,0xFFaca899);
     .fillRect(width-1,0,1,height,0xFFaca899);
     //标题栏
     .fillRect(2,2,width-4,25,0xFF408080);
     //文字
     .font.height=16;
     .drawText(4,5, title, 0xFFFFFF);
     .font.height=16;
  }
  //菜单
  with(message)
  {
     .visible=true;
     .left=(kag.scWidth-width)/2;
     .top=(kag.scHeight-height)/2;
     if (.top>=10) .top=10;
     .width=width;
     .height=height;
  }  
}
[endscript]
;---------------------------------------------------------------
;描绘文件listbox/描绘listbutton
;---------------------------------------------------------------
[iscript]
function drawBox(title,layer,left,top,width,line,array,page=0)
{

	title=getTransStr(title);

//设定长度
var height=(line+1)*20+5;

     with(layer)
  {
     //底板
     .fillRect(left,top,width,height,0xFFFFFFFF);
     //标题
     .fillRect(left+1,top+1,width-2,20,0xFFD8D8D8);
     .drawText(left+5,top+4,title,0x000000);
     .fillRect(left+1,top+21,width-2,1,0xFFaca899);
     //边框
     .fillRect(left,top,width,1,0xFFaca899);
     .fillRect(left,top,1,height,0xFFaca899);  
     .fillRect(left,top+height-1,width,1,0xFFaca899);
     .fillRect(left+width-1,top,1,height,0xFFaca899);
     //列表
     for (var i=line*page;i<line*page+line;i++)
     {
       if (i>=array.count) break;
       //选中
       if (f.select==i) .fillRect(left+1,top+23+(i-line*page)*20,width-2,20,0xFFCAFFFF);
		//文字
		var color=0x000000;
		if (array[i]=="start.story" || array[i]=="uititle.tjs") color=0xFF0000;

		//字体样式
		.font.height=16;
		.font.mapPrerenderedFont("font_16.tft");

		var str=array[i];
		str=str.substring(0,15);

       .drawText(left+5,top+1+24+(i-line*page)*20, str, color);
     }
  }
}

function drawButtonLine(posX,posY,normal,line,height)
{
  for (var i=0;i<line;i++)
  {
     kag.tagHandlers.locate(
     %[
         "x"=>posX,
         "y"=>posY+height*i
      ]
      );
      var setting=new Dictionary();
      setting.normal=normal;
      setting.exp="setselect("+i+","+line+")";
      kag.tagHandlers.button(setting);
  }
}
[endscript]

;-----------------------------------------------------------------------------------
[return]
