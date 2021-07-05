const expect = @import("std").testing.expect;

test "labelled blocks" {
    const count = blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        const n = new: {
            while (i < 10) : (i += 1) sum += i;
            if (sum > 10) {
                break :new;
            }
            else {
                break :blk sum;
            }
        };
        try expect(@TypeOf(n) == void);
        break :blk sum;
    };
    try expect(count == 45);
    try expect(@TypeOf(count) == u32);
}

test "nested continue" {
    var count: usize = 0;
    outer: for ([_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 }) |_| {
        for ([_]i32{ 1, 2, 3, 4, 5 }) |_| {
            count += 1;
            continue :outer;
        }
    }
    try expect(count == 8);
}

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression" {
    try expect(rangeHasNumber(0, 10, 3));
}

