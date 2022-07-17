const ncurses = @cImport(@cInclude("ncurses.h"));
const std = @import("std");

const snake = @import("snakeStructs.zig");

pub fn main() anyerror!void {
    const config = snake.Config{ .gamespeed = 70, .boardWidth = 80, .boardHeight = 40 };

    _ = ncurses.initscr();

    _ = ncurses.start_color();
    _ = ncurses.curs_set(0); //hide cursor
    _ = ncurses.cbreak();
    _ = ncurses.keypad(ncurses.stdscr, true);
    _ = ncurses.noecho();

    _ = ncurses.init_pair(1, ncurses.COLOR_CYAN, ncurses.COLOR_BLACK);
    _ = ncurses.attron(ncurses.COLOR_PAIR(1));
    _ = ncurses.printw("Press F1 to exit");
    _ = ncurses.refresh();

    const height = ncurses.getmaxy(ncurses.stdscr);
    const width = ncurses.getmaxx(ncurses.stdscr);

    const startY = @divTrunc(height, 2);
    const startX = @divTrunc(width, 2);

    const gameboard = ncurses.newwin(config.boardHeight, config.boardWidth, startY - @intCast(c_int, config.getYOffset()), startX - @intCast(c_int, config.getXOffset()));
    _ = ncurses.box(gameboard, 0, 0);
    _ = ncurses.wrefresh(gameboard);

    //var snek = snake.initSnake(config.getYOffset, config.getXOffset);

    game_loop(gameboard);

    _ = ncurses.endwin();

    std.debug.print("screen height: {}\n", .{height});
    std.debug.print("screen width: {}\n", .{width});
}

pub fn game_loop(window: *ncurses.WINDOW) void {
    var ch: i32 = 0;

    _ = window;
    while (ch != ncurses.KEY_F(1)) : (ch = ncurses.getch()) {
        switch (ch) {
            'a' => std.debug.print("a\n", .{}),
            else => {},
        }
    }
}
