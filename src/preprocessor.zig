const std = @import("std");
const classifier = @import("classifier.zig");
const symb = classifier.math_symbols;
const classify = classifier.classifier;

pub fn validate_parenthesis(input: []u8, buffer: []u8) bool {
    var pos: usize = 0;
    var is_valid: bool = true;

    for (input) |ch| {
        switch (ch) {
            '{', '[', '(' => {
                buffer[pos] = ch;
                pos += 1;
            },
            ')' => {
                if (pos == 0) return false;
                pos -= 1;
                is_valid = buffer[pos] == '(';
            },
            ']' => {
                if (pos == 0) return false;
                pos -= 1;
                is_valid = buffer[pos] == '[';
            },
            '}' => {
                if (pos == 0) return false;
                pos -= 1;
                is_valid = buffer[pos] == '{';
            },
            else => {},
        }
        if (is_valid == false) {
            return false;
        }
    }
    return pos == 0;
}

pub fn remove_unknown(input: []u8) void {
    var count: usize = 0;
    for (input, 0..) |ch, i| {
        if (classify(ch) == symb.unknown) {
            count += 1;
        } else {
            input[i - count] = ch;
        }
    }
    while (count > 0) : (count -= 1) {
        input[input.len - count] = 0;
    }
}

test "parenthesis test: matching" {
    var buffer: [7]u8 = [_]u8{ 0, 0, 0, 0, 0, 0, 0 };
    var str = [_]u8{ '(', ')', '[', ']', '{', '}' };
    try std.testing.expect(validate_parenthesis(&str, &buffer) == true);
}

test "parenthesis test: all left" {
    var buffer: [7]u8 = [_]u8{ 0, 0, 0, 0, 0, 0, 0 };
    var str = [_]u8{ '(', '(', '(', '(', '(', '(' };
    try std.testing.expect(validate_parenthesis(&str, &buffer) == false);
}

test "parenthesis test: all righ" {
    var buffer: [7]u8 = [_]u8{ 0, 0, 0, 0, 0, 0, 0 };
    var str = [_]u8{ ')', ')', ')', ')', ')', ')' };
    try std.testing.expect(validate_parenthesis(&str, &buffer) == false);
}

test "remove unknown symbols" {
    var str1 = [_]u8{ '#', 't', '#', '#', 'e', 's', 't', '#' };
    const str2 = [_]u8{ 't', 'e', 's', 't', 0, 0, 0, 0 };
    remove_unknown(&str1);
    try std.testing.expectEqual(str1, str2);
}
