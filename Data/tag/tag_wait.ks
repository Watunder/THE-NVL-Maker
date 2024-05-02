;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="等待操作"]

[group title="等待玩家点击" name="f.参数.tagname" x=30 y=50 comp="waitclick"]
[group title="等待时间" name="f.参数.tagname" x=30 y=80 comp="wait"]

[if exp="f.参数.tagname=='wait'"]
[line title="时间" name="f.参数.time" x=30 y=110]
;[line title="模式" name="f.参数.mode" x=30 y=80]
[check title="可略过" name="f.参数.canskip" x=30 y=140]
[endif]

[s]

*确认
[commit]
[eval exp="commitLine(f.参数)"]
[jump storage="tag_direct.ks" target=*擦除窗口]

*关闭选单
[jump storage="tag_direct.ks" target=*关闭选单]
