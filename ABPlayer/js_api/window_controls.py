from __future__ import annotations

import time
import typing as ty
import os
if os.name == 'nt':
    from ctypes import windll, Structure, c_long, byref
else:
    from ctypes import Structure, c_long, byref
    import Xlib
    from Xlib import display

from loguru import logger

import temp_file
from .js_api import JSApi
from .tools import ttl_cache


if ty.TYPE_CHECKING:
    import webview


class WindowControlsApi(JSApi):
    def __init__(self):
        self._full_screen = False

    def close_app(self) -> None:
        logger.debug("closing app")
        self._save_session_at_exit()
        self._window.destroy()

    def minimize_app(self) -> None:
        logger.trace("minimizing window")
        self._window.minimize()

    def toggle_full_screen_app(self) -> None:
        self._window.toggle_fullscreen()
        self._full_screen = not self._full_screen
        logger.trace(f"full screen toggled: {self._full_screen}")

    def drag_window(self) -> None:
        if self._full_screen:
            self.toggle_full_screen_app()
            move_to_cursor(self._window)
        drag_window(self._window)

    def resize_drag(self, size_grip: str) -> None:
        resize_handler(self._window, size_grip)

    def _save_session_at_exit(self) -> None:
        logger.debug("saving session data")
        scale_k = query_scale_k()
        width = int(self._window.width / scale_k)
        height = int(self._window.height / scale_k)
        is_main_menu_opened = self._window.evaluate_js("menu_opened")
        is_filter_menu_opened = self._window.evaluate_js("filter_menu_opened")
        required_drivers = self._window.evaluate_js("required_drivers")
        temp_file.update(
            width=width,
            height=height,
            is_main_menu_opened=is_main_menu_opened,
            is_filter_menu_opened=is_filter_menu_opened,
            required_drivers=",".join(required_drivers),
        )
        logger.trace("session data saved")


class POINT(Structure):
    _fields_ = [("x", c_long), ("y", c_long)]


def query_mouse_position() -> tuple[int, int]:
    pt = POINT()
    if os.name == 'nt':
        windll.user32.GetCursorPos(byref(pt))
    else:
        qp = display.Display().screen().root.query_pointer()
        pt.x = qp.root_x
        pt.y = qp.root_y
    print(pt)
    return pt.x, pt.y


@ttl_cache(5)
def query_scale_k() -> float:
    """
    Масштаб экрана(на ноутбуках обычно стоит 125%)
    """
    if os.name == 'nt':
        return windll.shcore.GetScaleFactorForDevice(0) / 100
    else:
        return 1


def resize(window: webview.Window, width: int, height: int) -> None:
    window.resize(width, height)


def move(window: webview.Window, x: int, y: int) -> None:
    scale_k = query_scale_k()
    window.move(int(x / scale_k), int(y / scale_k))


def resize_handler(window: webview.Window, size_grip):
    state_left = mouse_state()

    # Определяем начальное положение курсора, окна и его размер
    start_x, start_y = query_mouse_position()
    start_win_x = window.x
    start_win_y = window.y
    start_width = window.width
    start_height = window.height

    scale_k = query_scale_k()

    logger.trace(f"resize started: {size_grip}")

    while True:
        # Пользователь отпустил кнопку мыши
        if mouse_state() != state_left:
            logger.trace("resize finished")
            break

        current_x, current_y = query_mouse_position()

        # Определяем изменение значений в зависимости от области захвата
        delta_width = delta_height = delta_x = delta_y = 0
        # Обычное изменение размера окна
        if "bottom" in size_grip:
            delta_height = current_y - start_y
        if "right" in size_grip:
            delta_width = current_x - start_x
        # Изменение положения размера окна
        if "top" in size_grip:
            delta_y = current_y - start_y
            delta_height = -delta_y
            if (start_height + delta_height) / scale_k < window.min_size[1]:
                delta_height = int(window.min_size[1] * scale_k) - start_height
                delta_y = -delta_height
        if "left" in size_grip:
            delta_x = current_x - start_x
            delta_width = -delta_x
            if (start_width + delta_width) / scale_k < window.min_size[0]:
                delta_width = int(window.min_size[0] * scale_k) - start_width
                delta_x = -delta_width

        if delta_x or delta_y:
            # Изменяем положение окна
            move(window, start_win_x + delta_x, start_win_y + delta_y)
        # Изменяем размер окна
        resize(window, start_width + delta_width, start_height + delta_height)

        time.sleep(0.005)


def move_to_cursor(window: webview.Window) -> None:
    screen_width = 0
    if os.name == 'nt':
        screen_width = windll.user32.GetSystemMetrics(0)
    else:
        screen_width = display.Display().screen().width_in_pixels

    mouse_x = query_mouse_position()[0]
    window_width = window.width
    window.move(int(mouse_x - (window_width * mouse_x / screen_width)), 0)


def mouse_state():
    state_left = None
    if os.name == 'nt':
        state_left = windll.user32.GetKeyState(0x01)
    else:
        root = display.Display().screen().root
        root.change_attributes(event_mask=Xlib.X.Button1MotionMask & (
            Xlib.X.ButtonPressMask | Xlib.X.ButtonReleaseMask))
        while True:
            state_left = root.display.next_event()
    print(state_left)
    return state_left


def drag_window(window: webview.Window) -> None:
    state_left = mouse_state()

    # Определяем начальное положение курсора и окна
    start_x, start_y = query_mouse_position()
    start_win_x = window.x
    start_win_y = window.y

    logger.trace("drag started")

    while True:
        # Пользователь отпустил кнопку мыши
        if mouse_state() != state_left:
            logger.trace("drag finished")
            break

        current_x, current_y = query_mouse_position()

        delta_x = current_x - start_x
        delta_y = current_y - start_y

        move(window, start_win_x + delta_x, start_win_y + delta_y)

        time.sleep(0.005)