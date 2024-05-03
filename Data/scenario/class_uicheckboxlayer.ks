*start
[iscript]
class uiCheckboxLayer extends uiButtonLayer
{
	var on_over;

	function uiCheckboxLayer(elm)
	{
		super.uiButtonLayer(...);
	}
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
		var dic=super.ButtonElm();

		dic.on_over=this.on_over;
		return dic;
   }

   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
		this.on_over=elm.on_over;
		super.Reset(...);
   }

}
[endscript]
[return]
