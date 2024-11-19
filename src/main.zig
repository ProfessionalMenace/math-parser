const std = @import("std");
const pproces = @import("preprocessor.zig");
const parser = @import("parser.zig");

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const reader = stdin.reader();
    var input: [512]u8 = undefined;
    var buffer: [512]u8 = undefined;
    @memset(&buffer, 0);
    const bytes_read = try reader.readUntilDelimiterOrEof(&input, '\n');
    _ = bytes_read;
    pproces.remove_unknown(&input);
    const pvalid = pproces.validate_parenthesis(&input, &buffer);
    if (pvalid) {
        std.debug.print("Parenthesies are valid\n", .{});
    } else {
        std.debug.print("Parenthesies are invalid\n", .{});
    }

    // To do:
    // handle returning error
    // add checks
    //     valid parenthesis
    //     valid operators
    //     valid numbers
    // handle invalid input
    // preprocessing
    // processing
    // cleanup
    std.debug.print("Expression: {s}\n", .{input});
}
