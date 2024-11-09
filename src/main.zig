const std = @import("std");
const parser = @import("parser.zig");

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const reader = stdin.reader();
    var buffer: [512]u8 = undefined;
    _ = try reader.readUntilDelimiterOrEof(&buffer, '\n');
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
    std.debug.print("Expression: {s}\n", .{buffer});
}
