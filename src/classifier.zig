const std = @import("std");
const print = std.debug.print;

const math_symbols = enum {
    unknown,
    digit,
    variable,
    equal_sign,
    parenthesis,
    exponentiation,
    multiplication,
    division,
    addition,
    substraction,
};

pub fn classifier(ch: u8) math_symbols {
    const ret_val: math_symbols = switch (ch) {
        '0'...'9' => .digit,
        'a'...'z' => .variable,
        'A'...'Z' => .variable,
        '{', '}', '[', ']', '(', ')' => .parenthesis,
        '=' => .equal_sign,
        '*' => .multiplication,
        '/' => .division,
        '+' => .addition,
        '-' => .substraction,
        else => .unknown,
    };
    return ret_val;
}

test "Run classifier" {
    const string: []const u8 = "1+2-3*4+abc=69";
    for (string) |ch| {
        print("{c} {}\n", .{ ch, classifier(ch) });
    }
}
