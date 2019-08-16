//
//  LintStaged.swift
//

import Foundation
import PathKit
import SwiftCLI

public final class LintStaged {
    public enum LintStagedError: Error, CustomStringConvertible {
        case jsonDecodeFailed
        case configNotFound
        case invalidConfigData

        public var description: String {
            switch self {
            case .jsonDecodeFailed:
                return "json decode failed"
            case .configNotFound:
                return "config file not found"
            case .invalidConfigData:
                return "config file data is invalid"
            }
        }
    }

    private struct Config: Decodable {
        let fileExtensions: [String]
        let commands: [String]
        let stagedOnly: Bool?
    }

    private let arguments: [String]

    private let path: Path

    private var configPath: Path {
        return path + ".lint-staged"
    }

    public init(arguments: [String] = CommandLine.arguments, rootDir: String = Path.current.string) {
        self.arguments = arguments
        path = Path(rootDir)
    }

    public func run() throws {
        let configs = try getConfig()
        try configs.forEach { config in
            let files = try getChanged(stagedOnly: config.stagedOnly ?? false)
            files
                .filter { filename in
                    !config.fileExtensions
                        .filter { filename.hasSuffix("\($0)")}
                        .isEmpty
                }
                .forEach { filename in
                    config.commands.forEach { command in
                        let result = try! Task.capture(bash: "\(command) \(filename)")
                        print(result.stdout)
                    }
                }
        }
    }

    private func getConfig() throws -> [Config] {
        if configPath.exists {
            let configData: Data
            do {
                configData = try configPath.read()
            } catch {
                throw LintStagedError.configNotFound
            }

            do {
                return try JSONDecoder().decode([Config].self, from: configData)
            } catch {
                throw LintStagedError.invalidConfigData
            }
        } else {
            throw LintStagedError.configNotFound
        }
    }

    private func getChanged(stagedOnly: Bool) throws -> [String] {
        let result = try Task.capture(bash: "git diff --name-only" + (stagedOnly ? " --cached" : ""))
        return result.stdout.split(separator: "\n").map { String($0) }
    }
}
