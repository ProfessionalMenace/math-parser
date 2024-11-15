const std = @import("std");

pub const math_errors = enum {
    unknown_error,
    syntax_error,
    parenthesis_error,
};
