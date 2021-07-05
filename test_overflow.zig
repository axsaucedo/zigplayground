const expect = @import("std").testing.expect;

test "well defined overfloww" {
    var a: u8 = 255;
    a +%= 1;
    try expect(a == 0);
}
