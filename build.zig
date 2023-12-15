const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libxml2 = b.dependency("libxml2", .{
        .target = target,
        .optimize = optimize,
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
    exe.linkLibrary(libxml2.artifact("xml2"));
    exe.addCSourceFiles(.{ .files = &.{
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
    }, .flags = &.{
        "-Wno-comment",
        "-Wno-implicit-function-declaration",
        "-Wno-implicit-int",
    } });
    b.installArtifact(exe);
}
