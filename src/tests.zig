const std = @import("std");
const tst = std.testing;

const snake = @import("snakeStructs.zig");

test "initialize snake" {
    var snek = snake.initSnake(5, 5);

    try tst.expectEqual(@intCast(i32, 5), snek.tail.*.x);
    try tst.expectEqual(@intCast(i32, 3), snek.head.*.x);

    var sp = snek.head;

    try tst.expectEqual(@intCast(i32, 3), sp.*.x);

    sp = sp.next.?;

    try tst.expectEqual(@intCast(i32, 4), sp.*.x);

    sp = sp.next.?;

    try tst.expectEqual(@intCast(i32, 5), sp.*.x);
}
