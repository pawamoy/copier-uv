# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

<!-- insertion marker -->
## [1.2.6](https://github.com/pawamoy/copier-uv/releases/tag/1.2.6) - 2024-05-23

<small>[Compare with 1.2.5](https://github.com/pawamoy/copier-uv/compare/1.2.5...1.2.6)</small>

### Code Refactoring

- Reformat make script ([734f664](https://github.com/pawamoy/copier-uv/commit/734f6641dc360a04e19e00dfc090778eb66d9f2c) by Timothée Mazzucotelli).

## [1.2.5](https://github.com/pawamoy/copier-uv/releases/tag/1.2.5) - 2024-05-23

<small>[Compare with 1.2.4](https://github.com/pawamoy/copier-uv/compare/1.2.4...1.2.5)</small>

### Code Refactoring

- Remove pip self-hosted solution from insiders installation docs ([1743f52](https://github.com/pawamoy/copier-uv/commit/1743f521db021a345107f4f3f865d0ad2f1d5817) by Timothée Mazzucotelli).
- Rewrite make script in Python ([67fcd8b](https://github.com/pawamoy/copier-uv/commit/67fcd8bc08943dc437b7e0aa072786e88a0882ea) by Timothée Mazzucotelli).
- Rewrite duties using the new duty "tools" ([7d5a690](https://github.com/pawamoy/copier-uv/commit/7d5a690306c77772370f5715478d3f9d1f1a9cd9) by Timothée Mazzucotelli).
- Clean up pytest config ([1151e7d](https://github.com/pawamoy/copier-uv/commit/1151e7dd9f627d431116f5620e219239b8649107) by Timothée Mazzucotelli).
- Upgrade minimum versions of dev-deps ([b1622e9](https://github.com/pawamoy/copier-uv/commit/b1622e9f3ae3464dfb01dc1de73afa6312015626) by Timothée Mazzucotelli).
- Remove check-dependencies task for now ([618922f](https://github.com/pawamoy/copier-uv/commit/618922fe21e745d2ef121aaf8032352118d09429) by Timothée Mazzucotelli).

## [1.2.4](https://github.com/pawamoy/copier-uv/releases/tag/1.2.4) - 2024-04-26

<small>[Compare with 1.2.3](https://github.com/pawamoy/copier-uv/compare/1.2.3...1.2.4)</small>

### Bug Fixes

- Super final ultimate fix for publish duty ([f888d9f](https://github.com/pawamoy/copier-uv/commit/f888d9fc312dbdc3fb51227de2cc3d11191bd8b9) by Timothée Mazzucotelli).

## [1.2.3](https://github.com/pawamoy/copier-uv/releases/tag/1.2.3) - 2024-04-26

<small>[Compare with 1.2.2](https://github.com/pawamoy/copier-uv/compare/1.2.2...1.2.3)</small>

### Bug Fixes

- Further fixes to release/publish duties ([263580a](https://github.com/pawamoy/copier-uv/commit/263580a69cb725e0bf927c6cda5598f372087b73) by Timothée Mazzucotelli).

## [1.2.2](https://github.com/pawamoy/copier-uv/releases/tag/1.2.2) - 2024-04-26

<small>[Compare with 1.2.1](https://github.com/pawamoy/copier-uv/compare/1.2.1...1.2.2)</small>

### Bug Fixes

- Don't use modern annotations as duty fails evaluating them on Python 3.8 and 3.9 ([4cd01f9](https://github.com/pawamoy/copier-uv/commit/4cd01f9d6e5f4f866dc1b3ffe8f7f39ab407e2ba) by Timothée Mazzucotelli).

## [1.2.1](https://github.com/pawamoy/copier-uv/releases/tag/1.2.1) - 2024-04-26

<small>[Compare with 1.2.0](https://github.com/pawamoy/copier-uv/compare/1.2.0...1.2.1)</small>

### Bug Fixes

- Only print available tasks if venvs are setup ([0c65bdf](https://github.com/pawamoy/copier-uv/commit/0c65bdf186498fc701162d37a2029aba5760b867) by Timothée Mazzucotelli).
- Fix build and publish duties ([27eb549](https://github.com/pawamoy/copier-uv/commit/27eb5490128131c6681d4bb15d84950f8d971296) by Timothée Mazzucotelli).

## [1.2.0](https://github.com/pawamoy/copier-uv/releases/tag/1.2.0) - 2024-04-26

<small>[Compare with 1.1.0](https://github.com/pawamoy/copier-uv/compare/1.1.0...1.2.0)</small>

### Features

- Add `build` and `publish` duties ([5b4e70a](https://github.com/pawamoy/copier-uv/commit/5b4e70aac58c6633f4546a0784aedbe32f0e9576) by Timothée Mazzucotelli).
- Allow passing a `bump` value to the changelog duty ([2a1e535](https://github.com/pawamoy/copier-uv/commit/2a1e535818ddc990f7320277e77f1f3a06056a59) by Timothée Mazzucotelli).
- Allow passing release version interactively ([6839286](https://github.com/pawamoy/copier-uv/commit/6839286cf868a3bebcc91c4e62f8942c4c0496c3) by Timothée Mazzucotelli).
- All `allrun` and `3.x` commands to make script ([25c7e1b](https://github.com/pawamoy/copier-uv/commit/25c7e1b05ff12dfaf17074bdddb46ce222f027ab) by Timothée Mazzucotelli). [Issue-12](https://github.com/pawamoy/copier-uv/issues/12)
- Run tests with direct dependencies resolved to their lowest version ([339e2c6](https://github.com/pawamoy/copier-uv/commit/339e2c64c2ce542eff513324d7ab2100f816548f) by Timothée Mazzucotelli). [Issue-22](https://github.com/pawamoy/copier-uv/issues/22)

### Bug Fixes

- Don't include current project in credits ([77ae955](https://github.com/pawamoy/copier-uv/commit/77ae955bde1f5816eb6f2d83a0d5645643b33dfc) by Timothée Mazzucotelli). [Issue-18](https://github.com/pawamoy/copier-uv/issues/18)
- Fix parsing options in make scripts ([4dbb47c](https://github.com/pawamoy/copier-uv/commit/4dbb47cf0c308b4a2b405ed7300dbbf5523b0df5) by Timothée Mazzucotelli). [Issue-21](https://github.com/pawamoy/copier-uv/issues/21)

### Code Refactoring

- Prepare inclusion of manpages when building dists ([0a1151c](https://github.com/pawamoy/copier-uv/commit/0a1151caa2212ab1004db26766d25790f11d0d49) by Timothée Mazzucotelli).
- Use PEP 440 versioning scheme for changelog ([3f3a3c6](https://github.com/pawamoy/copier-uv/commit/3f3a3c6581278af39ca25ff6a53b27b7391e3000) by Timothée Mazzucotelli).
- Transform non Python tasks into make commands ([1b29786](https://github.com/pawamoy/copier-uv/commit/1b297864602c193c836603b9e90cd8c92ff75840) by Timothée Mazzucotelli).
- Sort credits case-insensitively ([459caf0](https://github.com/pawamoy/copier-uv/commit/459caf09e3709523cc0170823652be5a96777e34) by Timothée Mazzucotelli). [Issue-10](https://github.com/pawamoy/copier-uv/issues/10)
- Improve dev-deps, improve credits script ([c199b30](https://github.com/pawamoy/copier-uv/commit/c199b3049469b463299b42fac68299a77bd9fad8) by Timothée Mazzucotelli).
- Update badges ([5dba46f](https://github.com/pawamoy/copier-uv/commit/5dba46fa15cf04ad28b733bf1d61152e5166217a) by Timothée Mazzucotelli). [Issue-13](https://github.com/pawamoy/copier-uv/issues/13)
- Use current color for autorefs arrows ([f5e8745](https://github.com/pawamoy/copier-uv/commit/f5e8745879186c03bbe623f8347fb0580951c7c8) by Timothée Mazzucotelli). [Issue-19](https://github.com/pawamoy/copier-uv/issues/19)
- Add front-matter title to auto-generated reference pages ([8f33202](https://github.com/pawamoy/copier-uv/commit/8f33202840ea561f39ae7ab567eed8c8098baef0) by Timothée Mazzucotelli). [Issue-20](https://github.com/pawamoy/copier-uv/issues/20)
- Test on Python 3.13 ([e7806d9](https://github.com/pawamoy/copier-uv/commit/e7806d9e0358351496c1a9759c5d5f7d393744aa) by Timothée Mazzucotelli). [Issue-23](https://github.com/pawamoy/copier-uv/issues/23)
- uv is now able to install unnamed projects ([647579a](https://github.com/pawamoy/copier-uv/commit/647579a3cf33a42d373b86d35892b730ce70bdb6) by Timothée Mazzucotelli).

## [1.1.0](https://github.com/pawamoy/copier-uv/releases/tag/1.1.0) - 2024-03-19

<small>[Compare with 1.0.8](https://github.com/pawamoy/copier-uv/compare/1.0.8...1.1.0)</small>

### Features

- Add Python interpreter path to debug information ([9ab5feb](https://github.com/pawamoy/copier-uv/commit/9ab5feb3455302c0384a7c7ed42490e23fff10f1) by Timothée Mazzucotelli). [Issue-1](https://github.com/pawamoy/copier-uv/issues/1)
- Add Polar to funding file ([9e6c75f](https://github.com/pawamoy/copier-uv/commit/9e6c75f491725cb78626e3bf64bd78234f7bc4c8) by Timothée Mazzucotelli). [Issue-3](https://github.com/pawamoy/copier-uv/issues/3)

### Bug Fixes

- Fix issues with credits generation ([7384022](https://github.com/pawamoy/copier-uv/commit/73840229fc5be3106a71354e33a910b1e996161c) by Timothée Mazzucotelli). [Issue-4](https://github.com/pawamoy/copier-uv/issues/4)
- Correctly exclude fixtures from Ruff ([2dcda18](https://github.com/pawamoy/copier-uv/commit/2dcda18c230c0584a24e54fdf6098c4559716800) by Timothée Mazzucotelli). [Issue-6](https://github.com/pawamoy/copier-uv/issues/6)

### Code Refactoring

- Improve .gitignore and clean duty ([0590438](https://github.com/pawamoy/copier-uv/commit/0590438d94757ba2e672908cafdb0d0fef4aca96) by Timothée Mazzucotelli). [Issue-5](https://github.com/pawamoy/copier-uv/issues/5)
- Handle local/CI installation in `make setup` ([bddbbba](https://github.com/pawamoy/copier-uv/commit/bddbbbaf5915c60e35370dfa1316633ba802e980) by Timothée Mazzucotelli). [Issue-8](https://github.com/pawamoy/copier-uv/issues/8)
- Don't install pip, wheel and setuptools in venvs ([e423892](https://github.com/pawamoy/copier-uv/commit/e4238920184c5ba337adbbe3e0cf5ada44cd26c5) by Timothée Mazzucotelli). [Issue-9](https://github.com/pawamoy/copier-uv/issues/9)

## [1.0.8](https://github.com/pawamoy/copier-uv/releases/tag/1.0.8) - 2024-03-13

<small>[Compare with 1.0.7](https://github.com/pawamoy/copier-uv/compare/1.0.7...1.0.8)</small>

### Bug Fixes

- Remove prefix from completed goals HTML ids ([3e1d865](https://github.com/pawamoy/copier-uv/commit/3e1d865c27c48fb760a96928055e64460dcab765) by Timothée Mazzucotelli).

### Code Refactoring

- Link to global goal when there are no features ([fe6c538](https://github.com/pawamoy/copier-uv/commit/fe6c5382672f7c57b50de091c0af6aca9d4ffdfc) by Timothée Mazzucotelli).
- Prepare goal names ([fe89ca7](https://github.com/pawamoy/copier-uv/commit/fe89ca781f3c9758b61573cb5490183fd0661b13) by Timothée Mazzucotelli).

## [1.0.7](https://github.com/pawamoy/copier-uv/releases/tag/1.0.7) - 2024-03-13

<small>[Compare with 1.0.6](https://github.com/pawamoy/copier-uv/compare/1.0.6...1.0.7)</small>

### Code Refactoring

- Update premium sponsors display ([aabb40a](https://github.com/pawamoy/copier-uv/commit/aabb40aa4bae70b7b431f8857069e3a4ddc37fbc) by Timothée Mazzucotelli).

## [1.0.6](https://github.com/pawamoy/copier-uv/releases/tag/1.0.6) - 2024-03-02

<small>[Compare with 1.0.5](https://github.com/pawamoy/copier-uv/compare/1.0.5...1.0.6)</small>

### Code Refactoring

- Improve Insiders features paragraph ([8179314](https://github.com/pawamoy/copier-uv/commit/81793149195d112676c9b222510655f37955d6c9) by Timothée Mazzucotelli).

## [1.0.5](https://github.com/pawamoy/copier-uv/releases/tag/1.0.5) - 2024-02-29

<small>[Compare with 1.0.4](https://github.com/pawamoy/copier-uv/compare/1.0.4...1.0.5)</small>

### Bug Fixes

- Fix view/edit URIs in docs ([8fdf5dd](https://github.com/pawamoy/copier-uv/commit/8fdf5dd1192f5a868eb484e5bbc020e9c9b1d16a) by Timothée Mazzucotelli).

## [1.0.4](https://github.com/pawamoy/copier-uv/releases/tag/1.0.4) - 2024-02-28

<small>[Compare with 1.0.3](https://github.com/pawamoy/copier-uv/compare/1.0.3...1.0.4)</small>

### Bug Fixes

- I AM SO ANNOYED BY THIS OS ([2c5beb4](https://github.com/pawamoy/copier-uv/commit/2c5beb4f341f510ebb7d04ab29a02cf99c46195e) by Timothée Mazzucotelli).
- Fix dependencies installation in CI ([af33aab](https://github.com/pawamoy/copier-uv/commit/af33aabbbf75e8f76e05b82d20f8ac3f4cbb51aa) by Timothée Mazzucotelli).

## [1.0.3](https://github.com/pawamoy/copier-uv/releases/tag/1.0.3) - 2024-02-28

<small>[Compare with 1.0.2](https://github.com/pawamoy/copier-uv/compare/1.0.2...1.0.3)</small>

### Bug Fixes

- Fix parsing options now that the script exits on errors ([c800738](https://github.com/pawamoy/copier-uv/commit/c8007383ecfbb8edb54af31d54a0e136c82cb758) by Timothée Mazzucotelli).

## [1.0.2](https://github.com/pawamoy/copier-uv/releases/tag/1.0.2) - 2024-02-28

<small>[Compare with 1.0.1](https://github.com/pawamoy/copier-uv/compare/1.0.1...1.0.2)</small>

### Bug Fixes

- Fix uv install and credits again ([7ce4e3b](https://github.com/pawamoy/copier-uv/commit/7ce4e3b56c678637acc030655b13d6a87b30f0bd) by Timothée Mazzucotelli).

## [1.0.1](https://github.com/pawamoy/copier-uv/releases/tag/1.0.1) - 2024-02-28

<small>[Compare with 1.0.0](https://github.com/pawamoy/copier-uv/compare/1.0.0...1.0.1)</small>

### Bug Fixes

- Fix credits generation, preventing dev-deps to appear as runtime ones ([dfa6ed4](https://github.com/pawamoy/copier-uv/commit/dfa6ed40ab7caaa7aa475d6d48f3fbbaf8c32b38) by Timothée Mazzucotelli).
- Fix re-installation of deps ([ace356a](https://github.com/pawamoy/copier-uv/commit/ace356a0cea6bf6d074af8a8bbe35e846661abf0) by Timothée Mazzucotelli).

### Code Refactoring

- Update Ruff config file ([71713de](https://github.com/pawamoy/copier-uv/commit/71713defd32eb6e8597c90279fe23171a470c2e8) by Timothée Mazzucotelli).
- Clean up config files ([a9d58ac](https://github.com/pawamoy/copier-uv/commit/a9d58ac5a39ea043605d060e4863e6c36bbc0f8a) by Timothée Mazzucotelli).

## [1.0.0](https://github.com/pawamoy/copier-uv/releases/tag/1.0.0) - 2024-02-19

<small>[Compare with first commit](https://github.com/pawamoy/copier-uv/compare/ad5932b04cecfcc6e6d1311f10082289cbc6ed76...1.0.0)</small>

### Features

- Make it work with uv ([469fc45](https://github.com/pawamoy/copier-uv/commit/469fc459f04786c0064d746e778ef799e9a9eabc) by Timothée Mazzucotelli).
- Fork from [Copier PDM v1.2.3](https://pawamoy.github.io/copier-pdm/changelog/#123-2024-02-11)
