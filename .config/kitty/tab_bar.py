# pyright: reportMissingImports=false

from datetime import datetime

from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

opts = get_options()
CLOCK_FG = as_rgb(color_as_int(opts.color0))
CLOCK_BG = as_rgb(color_as_int(opts.color14))
DATE_FG = as_rgb(color_as_int(opts.color0))
DATE_BG = as_rgb(color_as_int(opts.color4))


def _draw_title(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
) -> int:
    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)
    trailing = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing
    overflow = screen.cursor.x - before - max_title_length
    if overflow > 0:
        screen.cursor.x -= overflow + 1
        screen.draw("…")
    if trailing:
        screen.draw(" " * trailing)

    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    screen.cursor.bg = 0
    return screen.cursor.x


def _draw_right_status(screen: Screen, is_last: bool) -> None:
    if not is_last:
        return

    now = datetime.now()
    cells = (
        (CLOCK_FG, CLOCK_BG, now.strftime(" %H:%M ")),
        (DATE_FG, DATE_BG, now.strftime(" %Y/%m/%d ")),
    )
    width = sum(len(text) for _, _, text in cells)
    screen.cursor.x = max(screen.cursor.x, screen.columns - width)

    for foreground, background, text in cells:
        screen.cursor.fg = foreground
        screen.cursor.bg = background
        screen.draw(text)
    screen.cursor.fg = screen.cursor.bg = 0


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    del extra_data
    end = _draw_title(
        draw_data, screen, tab, before, max_title_length, index, is_last
    )
    _draw_right_status(screen, is_last)
    return end
