;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;TJS条件生成器
;--------------------------------------------------
[iscript]
@"f.tjs_exp=${tf.当前编辑值}"!;
f.tjs_cond=[];
f.tjs_cond[1]=%[];
f.tjs_cond[2]=%[];
f.tjs_cond[3]=%[];
f.tjs_cond[4]=%[];

//默认值设定

f.tjs_cond[1].comp="==";
f.tjs_cond[2].comp="==";
f.tjs_cond[3].comp="==";
f.tjs_cond[4].comp="==";

f.tjs_cond[1].type="num";
f.tjs_cond[2].type="num";
f.tjs_cond[3].type="num";
f.tjs_cond[4].type="num";
[endscript]

*window
[window_up width=1024 height=768 title="TJS条件生成器"]
;--------------------------------------------------------------------------------

[eval exp="drawFrame('条件一',3,15,45,kag.fore.layers[7],960)"]

[line title="变量" name="f.tjs_cond[1].var1" x=30 y=95]

[group title="等于" name="f.tjs_cond[1].comp" x=350 y=65 comp="=="]
[group title="不等于" name="f.tjs_cond[1].comp" x=450 y=65 comp="!="]
[group title="大于" name="f.tjs_cond[1].comp" x=350 y=95 comp=">"]
[group title="小于" name="f.tjs_cond[1].comp" x=450 y=95 comp="<"]
[group title="大于等于" name="f.tjs_cond[1].comp" x=350 y=125 comp=">="]
[group title="小于等于" name="f.tjs_cond[1].comp" x=450 y=125 comp="<="]

[group title="数值" name="f.tjs_cond[1].type" x=670 y=65 comp="num"]
[line title="" name="f.tjs_cond[1].num2" x=715 y=65 true="f.tjs_cond[1].type=='num'" length=200]

[group title="字符" name="f.tjs_cond[1].type" x=670 y=95 comp="str"]
[line title="" name="f.tjs_cond[1].str2" x=715 y=95 true="f.tjs_cond[1].type=='str'" length=200]

[group title="变量" name="f.tjs_cond[1].type" x=670 y=125 comp="var"]
[line title="" name="f.tjs_cond[1].var2" x=715 y=125 true="f.tjs_cond[1].type=='var'" length=200]

;--------------------------------------------------------------------------------

[eval exp="drawFrame('条件二',3,15,185,kag.fore.layers[7],960)"]

[option title="并且" name="f.tjs_cond[2].and" x=30 y=205 false="f.tjs_cond[2].or"]
[option title="或者" name="f.tjs_cond[2].or" x=100 y=205 false="f.tjs_cond[2].and"]
[line title="变量" name="f.tjs_cond[2].var1" x=30 y=235]

[group title="等于" name="f.tjs_cond[2].comp" x=350 y=205 comp="=="]
[group title="不等于" name="f.tjs_cond[2].comp" x=450 y=205 comp="!="]
[group title="大于" name="f.tjs_cond[2].comp" x=350 y=235 comp=">"]
[group title="小于" name="f.tjs_cond[2].comp" x=450 y=235 comp="<"]
[group title="大于等于" name="f.tjs_cond[2].comp" x=350 y=265 comp=">="]
[group title="小于等于" name="f.tjs_cond[2].comp" x=450 y=265 comp="<="]

[group title="数值" name="f.tjs_cond[2].type" x=670 y=205 comp="num"]
[line title="" name="f.tjs_cond[2].num2" x=715 y=205 true="f.tjs_cond[2].type=='num'" length=200]

[group title="字符" name="f.tjs_cond[2].type" x=670 y=235 comp="str"]
[line title="" name="f.tjs_cond[2].str2" x=715 y=235 true="f.tjs_cond[2].type=='str'" length=200]

[group title="变量" name="f.tjs_cond[2].type" x=670 y=265 comp="var"]
[line title="" name="f.tjs_cond[2].var2" x=715 y=265 true="f.tjs_cond[2].type=='var'" length=200]

;--------------------------------------------------------------------------------
[eval exp="drawFrame('条件三',3,15,325,kag.fore.layers[7],960)"]

[option title="并且" name="f.tjs_cond[3].and" x=30 y=345 false="f.tjs_cond[3].or"]
[option title="或者" name="f.tjs_cond[3].or" x=100 y=345 false="f.tjs_cond[3].and"]
[line title="变量" name="f.tjs_cond[3].var1" x=30 y=375]

[group title="等于" name="f.tjs_cond[3].comp" x=350 y=345 comp="=="]
[group title="不等于" name="f.tjs_cond[3].comp" x=450 y=345 comp="!="]
[group title="大于" name="f.tjs_cond[3].comp" x=350 y=375 comp=">"]
[group title="小于" name="f.tjs_cond[3].comp" x=450 y=375 comp="<"]
[group title="大于等于" name="f.tjs_cond[3].comp" x=350 y=405 comp=">="]
[group title="小于等于" name="f.tjs_cond[3].comp" x=450 y=405 comp="<="]

[group title="数值" name="f.tjs_cond[3].type" x=670 y=345 comp="num"]
[line title="" name="f.tjs_cond[3].num2" x=715 y=345 true="f.tjs_cond[3].type=='num'" length=200]

[group title="字符" name="f.tjs_cond[3].type" x=670 y=375 comp="str"]
[line title="" name="f.tjs_cond[3].str2" x=715 y=375 true="f.tjs_cond[3].type=='str'" length=200]

[group title="变量" name="f.tjs_cond[3].type" x=670 y=405 comp="var"]
[line title="" name="f.tjs_cond[3].var2" x=715 y=405 true="f.tjs_cond[3].type=='var'" length=200]

;--------------------------------------------------------------------------------
[eval exp="drawFrame('条件四',3,15,465,kag.fore.layers[7],960)"]

[option title="并且" name="f.tjs_cond[4].and" x=30 y=485 false="f.tjs_cond[4].or"]
[option title="或者" name="f.tjs_cond[4].or" x=100 y=485 false="f.tjs_cond[4].and"]
[line title="变量" name="f.tjs_cond[4].var1" x=30 y=515]

[group title="等于" name="f.tjs_cond[4].comp" x=350 y=485 comp="=="]
[group title="不等于" name="f.tjs_cond[4].comp" x=450 y=485 comp="!="]
[group title="大于" name="f.tjs_cond[4].comp" x=350 y=515 comp=">"]
[group title="小于" name="f.tjs_cond[4].comp" x=450 y=515 comp="<"]
[group title="大于等于" name="f.tjs_cond[4].comp" x=350 y=545 comp=">="]
[group title="小于等于" name="f.tjs_cond[4].comp" x=450 y=545 comp="<="]

[group title="数值" name="f.tjs_cond[4].type" x=670 y=485 comp="num"]
[line title="" name="f.tjs_cond[4].num2" x=715 y=485 true="f.tjs_cond[4].type=='num'" length=200]

[group title="字符" name="f.tjs_cond[4].type" x=670 y=515 comp="str"]
[line title="" name="f.tjs_cond[4].str2" x=715 y=515 true="f.tjs_cond[4].type=='str'" length=200]

[group title="变量" name="f.tjs_cond[4].type" x=670 y=545 comp="var"]
[line title="" name="f.tjs_cond[4].var2" x=715 y=545 true="f.tjs_cond[4].type=='var'" length=200]

;--------------------------------------------------------------------------------
[line title="条件" name="f.tjs_exp" x=15 y=610 length=700]

[locate x=750 y=614]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*生成]
[eval exp="drawButtonCaption('生成条件')"]
[s]


*确认
[commit]
[iscript]
//将当前编辑的值展开为字符串，并将此字符串作为一个赋值式使用
@"${tf.当前编辑值}=f.tjs_exp"!;
[endscript]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]

*生成
[commit]
[iscript]

f.tjs_exp="";
//条件1
if (f.tjs_cond[1].var1!=void)
{
f.tjs_exp+="("+f.tjs_cond[1].var1+f.tjs_cond[1].comp;

if (f.tjs_cond[1].type=="num") {f.tjs_exp+=(int)f.tjs_cond[1].num2;}
else if (f.tjs_cond[1].type=="str") { f.tjs_exp+="\'"+f.tjs_cond[1].str2+"\'";}
else {f.tjs_exp +=f.tjs_cond[1].var2;}

f.tjs_exp+=")";
}

//条件2
if (f.tjs_cond[2].and==true) {f.tjs_exp+=" && ";}
else if (f.tjs_cond[2].or==true) {f.tjs_exp+=" || ";}

if (f.tjs_cond[2].var1!=void)
{
f.tjs_exp+="("+f.tjs_cond[2].var1+f.tjs_cond[2].comp;

if (f.tjs_cond[2].type=="num") {f.tjs_exp+=(int)f.tjs_cond[2].num2;}
else if (f.tjs_cond[2].type=="str") { f.tjs_exp+="\'"+f.tjs_cond[2].str2+"\'";}
else {f.tjs_exp +=f.tjs_cond[2].var2;}

f.tjs_exp+=")";
}

//条件3
if (f.tjs_cond[3].and==true) {f.tjs_exp+=" && ";}
else if (f.tjs_cond[3].or==true) {f.tjs_exp+=" || ";}

if (f.tjs_cond[3].var1!=void)
{
f.tjs_exp+="("+f.tjs_cond[3].var1+f.tjs_cond[3].comp;

if (f.tjs_cond[3].type=="num") {f.tjs_exp+=(int)f.tjs_cond[3].num2;}
else if (f.tjs_cond[3].type=="str") { f.tjs_exp+="\'"+f.tjs_cond[3].str2+"\'";}
else {f.tjs_exp +=f.tjs_cond[3].var2;}

f.tjs_exp+=")";
}


//条件4
if (f.tjs_cond[4].and==true) {f.tjs_exp+=" && ";}
else if (f.tjs_cond[4].or==true) {f.tjs_exp+=" || ";}

if (f.tjs_cond[4].var1!=void)
{
f.tjs_exp+="("+f.tjs_cond[4].var1+f.tjs_cond[4].comp;

if (f.tjs_cond[4].type=="num") {f.tjs_exp+=(int)f.tjs_cond[4].num2;}
else if (f.tjs_cond[4].type=="str") { f.tjs_exp+="\'"+f.tjs_cond[4].str2+"\'";}
else {f.tjs_exp +=f.tjs_cond[4].var2;}

f.tjs_exp+=")";

}



[endscript]
[jump target=*window]

