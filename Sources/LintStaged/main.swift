import LintStagedCore

let main = LintStaged()

do {
    try main.run()
} catch {
    print(error)
}
