;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;界面设定用的显示层(拖拽移动等效果及界面编辑窗口控件)
;-----------------------------------------------------------------------------------

;--------------------------------------------------------------
;特殊描绘-显示,隐藏对话框
;--------------------------------------------------------------
[iscript]
function drawView(title,layer,posX,posY,target)
{

	title=getTransStr(title);

  //描绘勾选框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+6]);
  var result=layer!.visible;
  //值为真
  if (result==true)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_visible",
    "exp"=>layer+".visible=false",
    "target"=>"*window"
    ]);
  }
  //值为假
  else if (result==false)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_invisible",
    "exp"=>layer+".visible=true",
    "target"=>"*window"
    ]);
  }

	//文字内容修改
	//title=NVL_i18n_translate(title);
	//描绘提示文字
	kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
	kag.tagHandlers.ch(%["text"=>title]);

  //描绘设定link
if (target!=void) 
  {     //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target=target;
        setting.hint=getTransStr("点此打开对话框详细设定窗口");
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
    }
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:地图按钮设定
;--------------------------------------------------------------
[iscript]
function drawMapButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint=getTransStr("点此打开地图按钮设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:系统按钮设定
;--------------------------------------------------------------
[iscript]
function drawButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint=getTransStr("点此打开按钮详细设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:背景样式设定
;--------------------------------------------------------------
[iscript]
function drawBackLayerSetting(title,layer,x,y)
{

  		//描绘文字
  		kag.tagHandlers.locate(%["x"=>x,"y"=>y]);
		title=getTransStr(title);
		kag.tagHandlers.ch(%["text"=>title]);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*背景设定";
        setting.hint=getTransStr("点此打开背景详细设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".LayerElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:CheckBox设定
;--------------------------------------------------------------
[iscript]
function drawCheckBoxSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*开关按钮设定";
        setting.hint="点此打开按钮详细设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ButtonElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:滑动槽设定
;--------------------------------------------------------------
[iscript]
function drawSliderSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*滑动槽设定";
        setting.hint=getTransStr("点此打开滑动槽详细设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".SliderElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;scroll层界面对应
;--------------------------------------------------------------
[iscript]
function drawScrollSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*滚动条";
        setting.hint="点此打开滚动条设定窗口";
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".ScrollElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:使用/不使用设定(+标签自定义)
;--------------------------------------------------------------
[iscript]
function drawSLsetting(title,layer,x,y,target)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       if (target!=void)
       {
         //空格
          kag.tagHandlers.ch(%["text"=>" "]);
         //连接
          var setting=new Dictionary();
          setting.target=target;
          setting.hint=getTransStr("点此打开详细设定窗口");
          setting.exp="tf.当前操作层="+layer;
          kag.tagHandlers.link(setting);
          //方块
          kag.tagHandlers.ch(%["text"=>"□"]);
          kag.tagHandlers.endlink(%[]);
       }
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:edu图形设定
;--------------------------------------------------------------
[iscript]
function drawEduPicSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*图形设定";
        setting.hint=getTransStr("点此打开养成面板图形&数值设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".LayerElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:edu文字设定
;--------------------------------------------------------------
[iscript]
function drawEduTextSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*文字设定";
        setting.hint=getTransStr("点此打开养成面板文字设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".LayerElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描绘:edu按钮设定
;--------------------------------------------------------------
[iscript]
function drawEduButtonSetting(title,layer,x,y)
{
       //勾选框
       drawCheck(title,layer+".visible",x,y);
       //空格
        kag.tagHandlers.ch(%["text"=>" "]);
       //连接
        var setting=new Dictionary();
        setting.target="*按钮设定";
        setting.hint=getTransStr("点此打开养成按钮设定窗口");
        //将值传递给f.参数并记录当前层的名字以便之后reset
        setting.exp="f.参数="+layer+".LayerElm(),tf.当前操作层=\'"+layer+"\'";
        kag.tagHandlers.link(setting);
        //方块
        kag.tagHandlers.ch(%["text"=>"□"]);
        kag.tagHandlers.endlink(%[]);
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
