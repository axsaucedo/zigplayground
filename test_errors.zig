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

