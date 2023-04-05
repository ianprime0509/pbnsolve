const std = @import("std");
const libxml2 = @import("lib/zig-libxml2/libxml2.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libxml2_lib = try libxml2.create(b, target, optimize, .{
        .iconv = false,
        .lzma = false,
        .zlib = false,
    });

    const exe = b.addExecutable(.{
        .name = "pbnsolve",
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibC();
    libxml2_lib.link(exe);
    exe.addCSourceFiles(&.{
        "src/bit.c",
        "src/clue.c",
        "src/contradict.c",
        "src/dump.c",
        "src/exhaust.c",
        "src/gamma.c",
        "src/grid.c",
        "src/http.c",
        "src/job.c",
        "src/line_cache.c",
        "src/line_lro.c",
        "src/merge.c",
        "src/pbnsolve.c",
        "src/probe.c",
        "src/puzz.c",
        "src/read.c",
        "src/read_bw.c",
        "src/read_grid.c",
        "src/read_olsak.c",
        "src/read_xml.c",
        "src/score.c",
        "src/solve.c",
    }, &.{});
    exe.install();
}
