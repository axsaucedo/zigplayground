const std = @import("std");

test "multidimensional arraylist" {
    const test_allocator = std.testing.allocator;
    var list = std.ArrayList(std.ArrayList(u32)).init(test_allocator);
    defer list.deinit();

    try list.append(std.ArrayList(u32).init(test_allocator));
    defer list.items[0].deinit();

    try list.items[0].append(1);

    try std.testing.expect(list.items[0].items[0] == 1);
}

