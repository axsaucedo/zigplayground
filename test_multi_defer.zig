const expect = @import("std").testing.expect;

test "multi defer" {
    var x: f32 = 5;
    {
        {
            defer x += 2;
            try expect(x == 5);
        }
        defer x /= 2;
        try expect(x == 7);
    }
    try expect(x == 3.5);
}
