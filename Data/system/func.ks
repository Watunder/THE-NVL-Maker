;------------------------------------------------------------
;   KAGeXpress ver 3.0 封装宏集
;   Author: Miliardo/2006.11.5
;   Author: 长山真夜/Ver 2.0
;
;   http://kcddp.keyfc.net/
;   (C) 2002-2006，Key Fans Club
;
;------------------------------------------------------------

@jump target=*init
;------------------------------------------------------------
;    初始设定
;------------------------------------------------------------

*init

@loadplugin module=wuvorbis.dll
@loadplugin module=wutcwf.dll
@loadplugin module=extrans.dll

@if exp="global.useconfigMappfont==true"
@mappfont storage=&global.configMappfont
@endif

@macro name=vend
@if exp="tf.KAGeXpress_voice=1"
@eval exp="tf.KAGeXpress_voice=0"
@endhact
@endif
@endmacro

@macro name=p
@vend
@oporig
@endmacro

@call storage=snow.ks
@call storage=rain.ks
@call storage=fog.ks
@call storage=picmove.ks
@call storage=oldMovie.ks
@call storage=timebar.ks

@call storage=staffroll.ks
@call storage=ExHistoryLayer.ks
@call storage=HistoryLayerCustom.ks

;------------------------------------------------------------
;    内容调整
;------------------------------------------------------------
@autolabelmode mode=true
@erafterpage mode=true
@history type=scroll
;------------------------------------------------------------
;    Macro区域（可根据情况自行调整）
;------------------------------------------------------------
;文字点击换行
@macro name=lr
@l
@r
@endmacro
;------------------------------------------------------------
;    Macro区域
;------------------------------------------------------------
@jump storage=first.ks

