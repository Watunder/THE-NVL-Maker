;------------------------------------------------
;picmover-背景循环移动插件
;by karryngai
;http://kcddp.keyfc.net/bbs/viewthread.php?tid=331&extra=page%3D1
;------------------------------------------------

;这个东西是用来实现背景循环地移动的，可以向不同的角度移动
;主要是在角色步行时或进入紧张氛围时使用
;背景最后设置成头尾可相接的循环，当分辨率是800*600时，图片最好设在1000*1000以上，当分辩率是640*480时，图片最好设在800*800以上，也就是矩形的对角线长度，主要是因为角度的问题
;
;@picmover layer=1 storage=picmover angle=120 speed=30 accel=12 time=10000 canstop=false
;layer                所在层，注意不能设成是base的，否则会出错误，因为base层不能移动
;                如果不设置，就会自动创建一个新层，这时会加添一个index的参数，可以改变其层次，默认是1
;storage                图片名
;angle                图片转了的角度，正数时逆时针旋转，默认是0，移动方向朝上
;speed                图片每秒移动的速度，单位是px/s，默认是100
;accel                加速度，可以设置成负数，速度变成负数后就会倒退回来，默认是0
;time                图片运行的时间，时间一到，图片就会停止，如果不设置，图片就会无限运动下去，默认是void
;canstop                canstop=true时，如果你设置的加速度为负数，当速度变为0时，图片就会停止，默认是false
;还有picmover有记忆能力，前面设置过参数了，参数就会保留下来，下次调用时可以不设置，除非你要去覆盖它
;
;@stoppicmover
;停止运动的图片
;
;@resumepicmover
;让停止运动的图片重新运动，运动时会恢复图片停止前的状态
;
;@clearpicmover
;清除图片，如果图片所在层是新层，必须要用此语句才能清除空间
;
;上面的语句同时和下面的语句运作
;@image layer=1 storage=loli visible=true left=300 top=200
;@action layer=1 module=LayerJumpActionModule vibration=30 cycle=3000
;便能实现背景移动，人物在走动的画面

@if exp="typeof(global.picmover_object)=='undefined'"
@iscript

class PicMover{
        var window;
        var angle;
        var storage;
        var speed,accel,stopaccel;
        var templayer,targetlayer;
        var tw,th;
        var time;
        var thistime,lasttime,last,starttime;
        var l;
        var canstop;
        var newlayer;
        var stoppingtime;

        function PicMover(window){
                this.window=window;
        }

        function setOption(elm){
                l=0;

                angle=elm.angle!==void?+elm.angle:(angle!==void?angle:0);
                storage=elm.storage if elm.storage!==void;

                speed=elm.speed!==void?+elm.speed:(speed!==void?speed:100);
                accel=elm.accel!==void?+elm.accel:(accel!==void?accel:0);
                stopaccel=elm.stopaccel!==void?+elm.stopaccel:(stopaccel!==void?stopaccel:0);

                time=elm.time!==void?+elm.time:(time!==void?time:void);

                canstop=elm.canstop!==void?elm.canstop:(canstop!==void?canstop:false);

                newlayer=false;
                if(elm.layer!==void){
                        targetlayer=window.getLayerFromElm(elm);
                        newlayer=true;
                }
                else if(targetlayer==void)
                        targetlayer=new AffineLayer(window,window.primaryLayer);
        }

        function initMove(){
                if(templayer==void)
                        templayer=new Layer(window,window.primaryLayer);

                templayer.loadImages(storage);

                tw=templayer.imageWidth;
                th=templayer.imageHeight;
                
                var pw=window.primaryLayer.width,ph=window.primaryLayer.height;
                targetlayer.setPos((pw-tw)/2,(ph-th)/2,tw,th);
                targetlayer.visible=true;
        }

        function startMove(elm){
                setOption(elm);
                initMove();
                
                starttime=last=System.getTickCount();
                System.addContinuousHandler(handler);
        }

        function handler(tick){
                thistime=(tick-starttime)/1000.0;
                lasttime=(last-starttime)/1000.0;
                last=tick;
                setAppearance();
        }

        function setAppearance(){
                l+=speed*(thistime-lasttime)+accel*(Math.pow(thistime,2)/2.0-Math.pow(lasttime,2)/2.0);
                l=l-(l\th)*th*1.0;
                if(l>=0){
                        targetlayer.copyRect(0,0,templayer,0,l,tw,th-l);
                        targetlayer.copyRect(0,th-l,templayer,0,0,tw,l);
                        targetlayer.rotate=angle;
                        targetlayer.update();
                }
                else{
                        targetlayer.copyRect(0,0,templayer,0,th+l,tw,-l);
                        targetlayer.copyRect(0,-l,templayer,0,0,tw,th+l);
                        targetlayer.rotate=angle;
                        targetlayer.update();
                }

                if(canstop && l<0) System.removeContinuousHandler(handler);

                if(time)
                        stopMove() if thistime>time/1000.0;
        }

        function stopMove(){
                stoppingtime=System.getTickCount();
                System.removeContinuousHandler(handler);
        }

        function resumeMove(){
                if(stoppingtime!==void){
                        var now=System.getTickCount();
                        starttime+=now-stoppingtime;
                        last+=now-stoppingtime;
                }
                System.addContinuousHandler(handler);
        }

        function clearMove(){
                System.removeContinuousHandler(handler);
                if(newlayer && targetlayer!==void) invalidate targetlayer;
                invalidate templayer if templayer!==void;
                targetlayer=templayer=void;
        }

        function finalize(){
                System.removeContinuousHandler(handler);
                if(newlayer && targetlayer!==void) invalidate targetlayer;
                invalidate templayer if templayer!==void;
                targetlayer=templayer=void;
        }
}
kag.addPlugin(global.picmover_object=new PicMover(kag));
@endscript
@endif

@macro name=picmover
@eval exp="global.picmover_object.startMove(mp)"
@endmacro

@macro name=stoppicmover
@eval exp="global.picmover_object.stopMove(mp)"
@endmacro

@macro name=resumepicmover
@eval exp="global.picmover_object.resumeMove(mp)"
@endmacro

@macro name=clearpicmover
@eval exp="global.picmover_object.clearMove(mp)"
@endmacro

@return
                                        
                
