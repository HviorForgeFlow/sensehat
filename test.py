from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD, ACTION_RELEASED
from signal import pause
import numpy


a = numpy.zeros(shape=(8,8)).astype(int)
y = 3
x = 3

sense = SenseHat()


def clamp(value, min_value=0, max_value=7):
    return min(max_value, max(min_value, value))

def pushed_up(event):
    global y
    if event.action != ACTION_RELEASED:
        y = clamp(y - 1)

def pushed_down(event):
    global y
    if event.action != ACTION_RELEASED:
        y = clamp(y + 1)

def pushed_left(event):
    global x
    if event.action != ACTION_RELEASED:
        x = clamp(x - 1)

def pushed_right(event):
    global x
    if event.action != ACTION_RELEASED:
        x = clamp(x + 1)
        
def pushed_middle(event):
    global a
    if event.action != ACTION_RELEASED:
        if a[y][x] == 0:
            a[y][x] = 1
        else:
            a[y][x] = 0


def refresh():
    sense.clear()
    for i in range(8):
        for j in range(8):
            if a[i][j] == 1:
                sense.set_pixel(j, i, 255, 255, 255)
    sense.set_pixel(x, y, 17, 253, 8)

while True:
    sense.stick.direction_up = pushed_up
    sense.stick.direction_down = pushed_down
    sense.stick.direction_left = pushed_left
    sense.stick.direction_right = pushed_right
    sense.stick.direction_middle = pushed_middle
    sense.stick.direction_any = refresh
    refresh()
    pause()