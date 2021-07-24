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

test "multidimensional arraylist initial size" {
    const test_allocator = std.testing.allocator;
    var list = try std.ArrayList(?std.ArrayList(u32)).initCapacity(test_allocator, 10);
    defer list.deinit();
    var i: usize = 0;
    while (i < 10) : (i += 1) {
        try list.append(null);
    }

    list.items[3] = std.ArrayList(u32).init(test_allocator);
    defer list.items[3].?.deinit();

    try list.items[3].?.append(1);

    try std.testing.expect(list.items[3].?.items[0] == 1);
}
