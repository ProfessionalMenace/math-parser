const std = @import("std");
const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;
const classifier = @import("classifier.zig");
const symb = classifier.math_symbols;
const classify = classifier.classifier;

pub fn slicer(expression: []u8) void {
    var last: symb = symb.unknown;
    var curr: symb = undefined;
    var count: usize = 0;
    for (expression, 0..) |ch, i| {
        curr = classify(ch);
        if (curr != last) {
            last = curr;
            count = 0;
        } else {
            count += 1;
        }
        std.debug.print("{s}\n", .{expression[i - count .. i + 1]});
    }
}

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

test "Basic lhs addition" {
    var string = [_]u8{ '1', '+', '1', '2', '=', '1', '3' };
    slicer(&string);
}
