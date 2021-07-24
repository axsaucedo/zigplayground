const expect = @import("std").testing.expect;

const Item = struct {
    val: u32,
};

fn passModifyStruct(it: Item) usize {
    var it2 = it;
    it2.val = 200;
    return @ptrToInt(&it2);
}

fn passStruct(it: Item) usize {
    return @ptrToInt(&it);
}

test "expect pass struct" {
    var it = Item{.val = 100};
    const optr = @ptrToInt(&it);
    const rptr = passStruct(it);
    const vptr = passModifyStruct(it);
    try expect(rptr == optr);
    try expect(vptr != optr);
    try expect(it.val == 100);
}

