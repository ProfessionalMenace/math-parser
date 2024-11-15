const std = @import("std");
const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

pub fn parse_int(slice: []u8) !i64 {
    return try parseInt(i64, slice, 10);
}

test "Test parse" {
    var string = [_]u8{ ' ', '1', '2', '3', '4', ' ' };
    const ok = parse_int(string[1..4]);
    std.debug.print("{any}\n", .{ok});
    const err = parse_int(&string);
    std.debug.print("{any}\n", .{err});
}
