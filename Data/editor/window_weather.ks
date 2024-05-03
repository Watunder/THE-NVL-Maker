;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="画面特效设定"]
[check title="下雨" name="f.config_title.rain" x=30 y=50]
[check title="下雪" name="f.config_title.snow" x=30 y=80]
[check title="樱花" name="f.config_title.sakura" x=30 y=110]
[check title="红叶" name="f.config_title.momiji" x=30 y=140]
[check title="旧电影" name="f.config_title.movie" x=30 y=170]
[check title="萤火虫" name="f.config_title.firefly" x=30 y=200]
[s]

*确认
[commit]


*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
