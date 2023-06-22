# Create Easy Toast Message On iOS

iOS에서 'ToastMessage'를 띄우기 위한 라이브러리로, layoutBox의 PinLayout을 기반으로 만들어졌습니다.

기본값이 정해져있지만, 사용자는 `ToastDesign`, `ToastLayout`, `ToastAnimation`, `ToastDirection`을 기반으로 커스텀 가능합니다.
또한 이미지를 추가할 수 있습니다.

기본 사용 방법은 아래와 같습니다.

``` swift
import Toast

func showToast() {
  Toast.showToast(message: "Toast Message")
}
```

`showToast()` 다음과 같이 구성됩니다.
- message: 토스트 메세지를 지정합니다.
- image: 토스트 좌측에 추가할 이미지를 지정합니다. 타입은 `UIImage` 입니다.
- design: `ToastDesign`으로 배경색, 텍스트 컬러 및 폰트를 지정합니다.
- layout: `ToastLayout`으로 토스트 및 내부 요소의 레이아웃을 지정합니다.
- animation: `ToastAnimation`으로 `show`, `hide`에 대한 애니메이션을 지정합니다.
- direction: `ToastDirection`으로 토스트 생성 방향을 지정합니다.


### Direction
BottomToTop
<p align="center">
  <img src="![bt](https://github.com/Guboneui/Toast/assets/73548875/93d82141-283c-46f3-8402-3faad815ddf6)">
</p>

TopToBottom
<p align="center">
  <img src="![tb](https://github.com/Guboneui/Toast/assets/73548875/60441333-1efa-4e1e-8a14-a1228486adf3)">
</p>

