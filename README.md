# Snow-World

macOS용 인터랙티브 겨울 데스크탑 프로젝트입니다. SwiftUI로 구성하며 서버, 계정, 원격 분석 없이 Mac 안에서 동작하는 것을 목표로 합니다.

## 현재 구현

- Tuist 기반 macOS 앱 프로젝트
- 겨울 산장 배경과 Canvas 눈 애니메이션
- 눈 내림/강도 설정을 갖춘 첫 실행 화면
- 메뉴 막대 메뉴에서 창 표시와 종료
- 설정은 `UserDefaults`에 로컬 저장

배경 에셋은 3840×2160으로 제공됩니다. 현재는 1672×941 생성 이미지를 고품질 리사이즈한 버전입니다.

> 현재 작업 환경은 Linux라 Xcode 빌드와 실기기 실행은 아직 검증하지 못했습니다. 아래 절차는 macOS에서 실행해야 합니다.

## 시작하기

1. macOS에 Xcode와 Tuist를 준비합니다.
2. 저장소 루트에서 `tuist generate`를 실행합니다.
3. 생성된 `SnowWorld.xcodeproj`를 열어 `SnowWorld` 스킴을 실행합니다.

```sh
tuist generate
open SnowWorld.xcodeproj
```

자세한 작업 범위와 다음 구현 단계는 [`docs/IMPLEMENTATION_PLAN.md`](docs/IMPLEMENTATION_PLAN.md)를 참고하세요.
