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

pub fn is_symb(ch: u8) bool {
    const ret_val: bool = switch (ch) {
        '+', '-', '=', '/', '^' => true,
        else => false,
    };
    return ret_val;
}

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

pub fn tokenizer(string: []const u8) void {
    for (string) |ch| {
        print("{c} {}\n", .{ ch, is_symb(ch) });
    }
}

test "Print tokens in expression" {
    const string: []const u8 = "1+2-3*4+abc=69";
    tokenizer(string);
}

test "Run classifier" {
    const string: []const u8 = "1+2-3*4+abc=69";
    for (string) |ch| {
        print("{c} {}\n", .{ ch, classifier(ch) });
    }
}
