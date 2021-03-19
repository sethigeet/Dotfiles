return {
    lintCommand = "pylint --max-line-length 160 ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f=%l:%c: %m"}
}
