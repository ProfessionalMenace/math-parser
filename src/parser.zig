const std = @import("std");
const print = std.debug.print;

pub fn is_symb(ch: u8) bool {
    const ret_val: bool = switch (ch) {
        '+', '-', '=', '/', '^' => true,
        else => false,
    };
    return ret_val;
}

pub fn tokenizer(string: []const u8) void {
    for (string) |ch| {
        print("{c} {}\n", .{ ch, is_symb(ch) });
    }
}

test "Print tokens in expression" {
    const string: []const u8 = "1+2-3*4+abc=69";
    tokenizer(string);
}
