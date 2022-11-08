pub const Config = struct {
    gamespeed: i32,
    boardHeight: i32,
    boardWidth: i32,

    pub fn getYOffset(self: *const Config) i32 {
        return @divTrunc(self.boardHeight, 2);
    }

    pub fn getXOffset(self: *const Config) i32 {
        return @divTrunc(self.boardWidth, 2);
    }
};

pub const Segment = struct {
    y: i32,
    x: i32,
    next: ?*Segment = null,
};

//snake is implemented as a queue of segments
pub const Queue = struct {
    //counter-intuitively, the head of the snake is the tail of the queue and vice versa
    head: *Segment,
    tail: *Segment,

    pub fn enqueue(self: *Queue, newSegment: *Segment) void {
        self.tail.next = newSegment;
        self.tail = newSegment;
    }

    //does not free the head, caller must do so
    pub fn dequeue(self: *Queue) *Segment {
        var oldHead = self.head;
        self.head = oldHead.next;
        return oldHead;
    }
};

pub fn initSnake(snakeHeadY: i32, snakeHeadX: i32) Queue {
    var sHead = Segment{ .y = snakeHeadY, .x = snakeHeadX };
    var sBody = Segment{ .y = snakeHeadY, .x = snakeHeadX - 1, .next = &sHead };
    var sTail = Segment{ .y = snakeHeadY, .x = snakeHeadX - 2, .next = &sBody };

    //because of the way the snake moves, the head of the queue is the tail of the snake
    return Queue{ .head = &sTail, .tail = &sHead };
}
