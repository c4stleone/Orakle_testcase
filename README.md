# Foundry Custom Revert Example

Foundry로 Solidity custom error revert를 테스트하는 최소 예제 프로젝트입니다.

핵심 예제는 `mint(0)` 호출이 `MintAmountZero()` custom error로 revert되는지 확인하는 테스트입니다.

```solidity
bytes4 expectedSelector = MintExample.MintAmountZero.selector;

vm.expectRevert(expectedSelector);
token.mint(0);
```

## Requirements

- Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

설치 확인:

```bash
forge --version
cast --version
anvil --version
chisel --version
```

## Project Layout

```text
.
├── foundry.toml
├── script/
│   └── DeployMintExample.s.sol
├── src/
│   └── MintExample.sol
└── test/
    └── MintCustomRevert.t.sol
```

## Build

```bash
forge build
```

## Test

전체 테스트:

```bash
forge test
```

특정 테스트 컨트랙트만 실행:

```bash
forge test --match-contract MintCustomRevertTest
```

특정 테스트 함수만 실행:

```bash
forge test --match-test test_RevertWhen_MintAmountIsZero_WithCustomErrorSelector4Bytes
```

trace 자세히 보기:

```bash
forge test --match-test test_RevertWhen_MintAmountIsZero_WithCustomErrorSelector4Bytes -vvvvv --suppress-successful-traces
```

gas report:

```bash
forge test --gas-report
```

## What This Project Shows

- `vm.expectRevert(bytes4)`로 custom error selector 4 bytes만 검증하기
- `vm.expectRevert(bytes)`와 `abi.encodeWithSelector(...)`로 전체 revert data 검증하기
- parameter가 있는 custom error 검증하기
- revert string과 custom error 테스트 비교하기
- `forge test --match-contract`, `--match-test`, verbosity 옵션 사용하기

## GitHub Push

새 GitHub repository를 만든 뒤 아래 명령을 실행합니다.

```bash
git remote add origin https://github.com/<YOUR_ID>/foundry-custom-revert-example.git
git branch -M main
git push -u origin main
```

GitHub CLI를 쓴다면:

```bash
gh repo create foundry-custom-revert-example --public --source=. --remote=origin --push
```
