# lint-staged.swift

Run script(like linter or formatter) against staged git files.

## Usage

### Configuration

create `.lint-staged` on project root directory.

#### .lint-staged

```
[
    {
        "fileExtensions": ["swift"],
        "commands": ["swift-format -i"],
        "stagedOnly": true
    }
]
```

### Run

```
swift run -c release lint-staged
```

#### Mint

```
mint run yanamura/lint-staged lint-staged
```
