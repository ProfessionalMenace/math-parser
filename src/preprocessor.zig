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
    input[input.len - count] = 0;
}

test "remove unknown symbols" {
    var str: [5]u8 = .{ 't', ' ', 'e', 's', 't' };
    remove_unknown(&str);
    std.debug.print("{s}\n", .{str});
}
