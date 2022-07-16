const ncurses = @cImport(@cInclude("ncurses.h"));
const std = @import("std");

const snake = @import("snakeStructs.zig");

pub fn main() anyerror!void {
    _ = ncurses.initscr();
    _ = ncurses.endwin();

    var q = snake.initSnake(3, 3);
    std.debug.print("snake head x: {}\n", .{q.tail.x});
    // Note that info level log messages are by default printed only in Debug
    // and ReleaseSafe build modes.
    std.log.info("All your codebase are belong to us.", .{});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
