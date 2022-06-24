# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

- - -

## [0.1.3](https://github.com/eviweb/qa-tools/compare/0.1.2..0.1.3) - 2022-06-24

### Bug Fixes

- **(hook)** 🐛 fix regression that prevented displaying the cog verify message - ([28d5507](https://github.com/eviweb/qa-tools/commit/28d550707985358a6b7768b05267150703a0141b)) - [@eviweb](https://github.com/eviweb)
- **(hook)** 🐛 cog always returns status 0 so interpret the command output - ([fb6d225](https://github.com/eviweb/qa-tools/commit/fb6d22577b3bc290a50bd0d68a5ee8277b9eed10)) - [@eviweb](https://github.com/eviweb)

### Features

- **(hook)** ✨ allows to disable commit message checking - ([97f88af](https://github.com/eviweb/qa-tools/commit/97f88af90f6ae4b40526f0e207a0b249ecec540d)) - [@eviweb](https://github.com/eviweb)

### Miscellaneous Chores

- **(test)** 🧹 add new_temp_file helper function - ([5acdb4b](https://github.com/eviweb/qa-tools/commit/5acdb4b5a75a1ec38da4b9ff376ce46acdb270a5)) - [@eviweb](https://github.com/eviweb)

### Tests

- **(hook)** ✅ add commit-msg hook tests - ([adbc7b0](https://github.com/eviweb/qa-tools/commit/adbc7b0338baf22f16e505e6bb663b32afb75e25)) - [@eviweb](https://github.com/eviweb)

- - -


## [0.1.2](https://github.com/eviweb/qa-tools/compare/0.1.1..0.1.2) - 2022-04-25

### Bug Fixes

- **(insert-icon)** 🐛 fix sed command to accept commit messages containing '/' - ([dfe45d6](https://github.com/eviweb/qa-tools/commit/dfe45d699f2545f794d0d91ddbc0e9a59732148c)) - [@eviweb](https://github.com/eviweb)

### Miscellaneous Chores

- **(test)** 🧹 now the test runner can run a unique test file - ([c3cb3ee](https://github.com/eviweb/qa-tools/commit/c3cb3eeebabeca2f399b555cbe670483a0918c5d)) - [@eviweb](https://github.com/eviweb)
- **(test)** 🧹 fix display format of running tests - ([984d783](https://github.com/eviweb/qa-tools/commit/984d783a9b1a3f0048ef02b0706865fab410aa0e)) - [@eviweb](https://github.com/eviweb)

- - -


## [0.1.1](https://github.com/eviweb/qa-tools/compare/0.1.0..0.1.1) - 2022-04-21

### Bug Fixes

- **(insert-icon)** 🐛 fix command for a multiline message with an icon - ([2587e9e](https://github.com/eviweb/qa-tools/commit/2587e9ebee166d2b9fe69bc1230e629b9970a3a3)) - [@eviweb](https://github.com/eviweb)

### Configuration

- **(icon)** ⚙️  add typo commit type and related icon - ([1b2291d](https://github.com/eviweb/qa-tools/commit/1b2291daaa3e89d69f101f183c734e17d57f9a10)) - [@eviweb](https://github.com/eviweb)

### Miscellaneous Chores

- **(changelog)** 🧹 fix CHANGELOG.md format and links to author Github profile - ([0c05eac](https://github.com/eviweb/qa-tools/commit/0c05eace2828fa1b9bd48d6edf8894223047f1e4)) - [@eviweb](https://github.com/eviweb)
- **(changelog)** 🧹 update template to follow MD rules - ([bac2acf](https://github.com/eviweb/qa-tools/commit/bac2acf6a4a3488337f7ea215398532241742c42)) - [@eviweb](https://github.com/eviweb)

### Tests

- **(insert-icon)** ✅ add test for a multiline commit message with an icon - ([f180c8a](https://github.com/eviweb/qa-tools/commit/f180c8a6b7d0dc2922a2711c20c5e8b86cb158cb)) - [@eviweb](https://github.com/eviweb)

### Typo correction

- **(config)** ✏️  correct lastname in changelog author signature - ([ff75c28](https://github.com/eviweb/qa-tools/commit/ff75c2876eea44a00f9f73317d4797aa5a72466b)) - [@eviweb](https://github.com/eviweb)

- - -

## [0.1.0](https://github.com/eviweb/qa-tools/compare/92ba9397a9cec5008219a96682dd54b133570550..0.1.0) - 2022-04-21

### Configuration

- **(changelog)** ⚙️  add changelog config options - ([0715169](https://github.com/eviweb/qa-tools/commit/0715169ea6a998363fd3e04ae91c209108f81acf)) - [@eviweb](https://github.com/eviweb)
- ⚙️  set custom types and related icons - ([21b7ef5](https://github.com/eviweb/qa-tools/commit/21b7ef5f2c71df2d8b462e24f54f608aa461dcdd)) - [@eviweb](https://github.com/eviweb)

### Documentation

- 📚 add README.md - ([95c63b6](https://github.com/eviweb/qa-tools/commit/95c63b6adf690785c7f0f0457ece878ab7998bd4)) - [@eviweb](https://github.com/eviweb)

### Features

- **(git-hook)** ✨ add commit-msg git hook - ([d99449b](https://github.com/eviweb/qa-tools/commit/d99449b2feeb8ba686a10df3356a816b8ac01a39)) - [@eviweb](https://github.com/eviweb)
- **(insert-icon)** ✨ implement insert-icon command - ([78afa3a](https://github.com/eviweb/qa-tools/commit/78afa3a2316cedfcd80b2674f7264d914ae1e6fc)) - [@eviweb](https://github.com/eviweb)

### Miscellaneous Chores

- **(changelog)** 🧹 add CHANGELOG.md + changelog cog template - ([5fdf1ce](https://github.com/eviweb/qa-tools/commit/5fdf1ce0f7da33d774eeb98a7426349f5aa29aff)) - [@eviweb](https://github.com/eviweb)
- **(install)** 🧹 add installer - ([a01e62c](https://github.com/eviweb/qa-tools/commit/a01e62c05614514b348183efbb05c4e4fd8b524a)) - [@eviweb](https://github.com/eviweb)
- **(templates)** 🧹 import default git templates - ([1a19055](https://github.com/eviweb/qa-tools/commit/1a19055a1bf027182149567b9ff58a88004cbfa9)) - [@eviweb](https://github.com/eviweb)
- **(version)** 0.1.0 - ([91d6461](https://github.com/eviweb/qa-tools/commit/91d6461a0cf1ab5a0bedd9f4ab98781b0eec60e5)) - [@eviweb](https://github.com/eviweb)

### Tests

- **(insert-icon)** ✅ add unit tests and related fixtures - ([0a69af1](https://github.com/eviweb/qa-tools/commit/0a69af16eeadb613dc7e858cece7e4e506057310)) - [@eviweb](https://github.com/eviweb)
- ✅ add runner and functions - ([cf5092a](https://github.com/eviweb/qa-tools/commit/cf5092a32a5db11ab7b35df9e043bf8dcb207542)) - [@eviweb](https://github.com/eviweb)

### Tooling

- **(binary)** 🔧 add commands to bin directory - ([77545f1](https://github.com/eviweb/qa-tools/commit/77545f1ec96cdfdac711d9bd6609d0bd7111975e)) - [@eviweb](https://github.com/eviweb)
- **(vendor)** 🔧 add third party tools - ([c1a4889](https://github.com/eviweb/qa-tools/commit/c1a48892ad572bf11d7f457ca4c51d7579ea483b)) - [@eviweb](https://github.com/eviweb)

- - -

