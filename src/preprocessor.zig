const std = @import("std");
const cls = @import("classifier.zig");

pub fn validate_parethesis(input: []u8, buffer: []u8) void {
    std.debug.print("Validating...", .{});
    _ = input;
    _ = buffer;
}

pub fn remove_unknown(input: []u8) void {
    var count: usize = 0;
    for (input, 0..) |ch, i| {
        if (cls.classifier(ch) == cls.math_symbols.unknown) {
            count += 1;
        } else if (count > 0) {
            input[i - count] = ch;
        }
    }
    while (count > 0) : (count -= 1) {
        input[input.len - count] = 0;
    }
}

test "remove unknown symbols" {
    var str1 = [_]u8{ '#', 't', '#', '#', 'e', 's', 't', '#' };
    const str2 = [_]u8{ 't', 'e', 's', 't', 0, 0, 0, 0 };
    remove_unknown(&str1);
    try std.testing.expectEqual(str1, str2);
}
