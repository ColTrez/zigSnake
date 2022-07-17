pub const Config = struct {
    gamespeed: u32,
    boardHeight: u32,
    boardWidth: u32,

    pub fn getYOffset(self: *const Config) u32 {
        return self.boardHeight / 2;
    }

    pub fn getXOffset(self: *const Config) u32 {
        return self.boardWidth / 2;
    }
};

pub const Segment = struct {
    y: u32,
    x: u32,
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

pub fn initSnake(snakeHeadY: u32, snakeHeadX: u32) Queue {
    var sHead = Segment{ .y = snakeHeadY, .x = snakeHeadX };
    var sBody = Segment{ .y = snakeHeadY, .x = snakeHeadX - 1, .next = &sHead };
    var sTail = Segment{ .y = snakeHeadY, .x = snakeHeadX - 2, .next = &sBody };

    //because of the way the snake moves, the head of the queue is the tail of the snake
    return Queue{ .head = &sTail, .tail = &sHead };
}
