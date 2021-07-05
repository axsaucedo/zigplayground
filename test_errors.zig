const expect = @import("std").testing.expect;

const FileOpenError = error {
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from subset to superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union not error" {
    const orig_val: u16 = 10;
    const other_val: u16 = 0;
    const not_error: AllocationError!u16 = orig_val;
    const err_not = not_error catch other_val;

    try expect(@TypeOf(err_not) == u16);
    try expect(err_not == orig_val);
}

test "error union yes error" {
    const other_val: u16 = 0;
    const yes_error: AllocationError!u16 = AllocationError.OutOfMemory;
    const err_yes = yes_error catch other_val;

    try expect(@TypeOf(err_yes) == u16);
    try expect(err_yes == other_val);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        // try x is a shortcut for x catch |err| return err
        try expect(err == error.Oops);
        return;
    };
}

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "testing try" {
    var v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 13); // Never reached
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();
}

fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}



