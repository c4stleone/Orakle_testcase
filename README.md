# Foundry Custom Revert Exercise

Foundry로 Solidity custom error revert 테스트를 연습하는 빈칸형 실습 프로젝트입니다.

`test/MintCustomRevert.t.sol`에는 일부러 틀린 값과 `TODO` 빈칸이 들어 있습니다. 처음 `forge test`를 실행하면 실패하는 것이 정상입니다. 빈칸을 채워서 모든 테스트를 통과시키는 것이 목표입니다.

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
├── solutions/
│   └── MintCustomRevert.solution.t.sol
├── src/
│   └── MintExample.sol
└── test/
    └── MintCustomRevert.t.sol
```

## Exercise Goal

아래 개념을 직접 테스트 코드로 채워 넣습니다.

- `vm.expectRevert(bytes4)`로 custom error selector 4 bytes만 검증하기
- `vm.expectRevert(bytes)`와 `abi.encodeWithSelector(...)`로 전체 revert data 검증하기
- parameter가 있는 custom error 검증하기
- 성공 케이스에서 `balanceOf` 변화 검증하기
- revert string 테스트와 custom error 테스트 비교하기

## Start

먼저 실패하는 테스트를 확인합니다.

```bash
forge test
```

그다음 [test/MintCustomRevert.t.sol](test/MintCustomRevert.t.sol)의 `TODO`를 채웁니다.

특정 테스트만 실행:

```bash
forge test --match-test test_RevertWhen_MintAmountIsZero_WithCustomErrorSelector4Bytes
```

trace 자세히 보기:

```bash
forge test --match-test test_RevertWhen_MintAmountIsZero_WithCustomErrorSelector4Bytes -vvvvv --suppress-successful-traces
```

컨트랙트 단위로 실행:

```bash
forge test --match-contract MintCustomRevertTest
```

gas report:

```bash
forge test --gas-report
```

## Blank Questions

### 1. Custom error selector 4 bytes

`mint(0)`이 `MintAmountZero()`로 revert되는지 selector만 검증하세요.

```solidity
bytes4 expectedSelector = MintExample.________________.selector;

vm.expectRevert(expectedSelector);
token.mint(___);
```

### 2. Full revert data

`abi.encodeWithSelector(...)`를 사용해서 전체 revert data를 검증하세요.

```solidity
vm.expectRevert(
    abi.encodeWithSelector(MintExample.________________.selector)
);
token.mint(___);
```

### 3. Parameter custom error

`InvalidMintAmount(uint256 amount)`의 selector와 argument를 함께 검증하세요.

```solidity
uint256 invalidAmount = token.MAX_MINT_PER_TX() + ___;

vm.expectRevert(
    abi.encodeWithSelector(
        MintExample.________________.selector,
        invalidAmount
    )
);
token.mint(invalidAmount);
```

### 4. Success case

`mint(1)`이 성공하고 `balanceOf[address(this)] == 1`인지 검증하세요.

```solidity
token.mint(___);

assertEq(token.balanceOf(address(this)), ___);
```

### 5. Revert string

revert string 버전도 검증하세요.

```solidity
vm.expectRevert(bytes("____________________"));
stringRevertToken.mint(___);
```

## Reference Solution

정답 확인이 필요하면 `solutions/MintCustomRevert.solution.t.sol`을 참고하세요.

정답 파일을 테스트 파일에 덮어써서 바로 확인하려면:

```bash
cp solutions/MintCustomRevert.solution.t.sol test/MintCustomRevert.t.sol
forge test -vv
```

## CI Note

GitHub Actions는 `solutions/MintCustomRevert.solution.t.sol`을 `test/MintCustomRevert.t.sol`에 복사한 뒤 reference solution을 검증합니다. 그래서 starter test가 처음에 실패하더라도 repository CI는 정답 기준으로 통과할 수 있습니다.

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
