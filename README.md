# iOS Toast Message

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

---
### Installation
#### Swift Package Manager
``` swift
dependencies: [
  .package(url: "https://github.com/Guboneui/Toast", .upToNextMajor(from: "1.0.0"))
]
```
---

`showToast()` 다음과 같이 구성됩니다.
- message: 토스트 메세지를 지정합니다.
- image: 토스트 좌측에 추가할 이미지를 지정합니다. 타입은 `UIImage` 입니다.
- design: `ToastDesign` 타입으로 배경색, 텍스트 컬러 및 폰트를 지정합니다.
- layout: `ToastLayout` 타입으로 토스트 및 내부 요소의 레이아웃을 지정합니다.
- animation: `ToastAnimation` 타입으로 `show`, `hide`에 대한 애니메이션을 지정합니다.
- direction: `ToastDirection` 타입으로 토스트 생성 방향을 지정합니다.
- addHideGesture: `true`로 지정할 경우, swipe, tap 제스처를 통해 토스트 메세지가 사라집니다.

### Direction
#### BottomToTop
<p align="left">
  <img src="https://github.com/Guboneui/Toast/assets/73548875/3a681cf6-c693-489a-a611-48868c0e8579" width=200>
</p>

#### TopToBottom
<p align="left">
  <img src="https://github.com/Guboneui/Toast/assets/73548875/e6908b1f-fc9f-4aa0-b147-3bd8bbcd7456" width=200>
</p>


### ToastDesign
토스트의 디자인을 커스텀 할 수 있습니다.
- bgColor: `UIColor` 타입으로 배경색을 지정합니다. 기본 색상은 `.black`입니다.
- textColor: `UIColor` 타입으로 메세지 텍스트 색상을 지정합니다. 기본 색상은 `.white`입니다.
- textFont: `UIFont` 타입으로 메세지 텍스트 폰트를 지정합니다. 기본 폰트는 `.systemFont(ofSize: 14, weight: .medium)`입니다.
- cornerRadius: `CGFloat` 타입으로 cornerRadius 값을 지정합니다. 기본값은 `4.0` 입니다.

#### Example
``` swift
func showToast() {
  let toastDesign: ToastDesign = ToastDesign(
    bgColor: .green.withAlphaComponent(0.8),
    textColor: .blue,
    textAlignment: .center,
    textFont: UIFont.systemFont(ofSize: 24, weight: .bold),
    cornerRadius: 0
  )
  
  Toast.showToast(
    message: "Toast Message",
    design: toastDesign
  )
}
```
<p align="left">
  <img src="https://github.com/Guboneui/Toast/assets/73548875/076f246a-0ac5-4391-b0af-4d57e4b71e4b" width=200>
</p>

---
### ToastLayout
토스트의 레이아웃을 커스텀 할 수 있습니다.
- imageSize: `CGSize?` 타입으로 이미지 추가 시 크기를 지정합니다. 기본 크기는 `CGSize(width: 18, height: 18)`입니다.
- imageLabelOffset: `CGFloat` 타입으로 이미지와 메세지 간격을 설정합니다. 기본 간격은 `8.0`입니다.
- toastOffset: `CGFloat` 타입으로 토스트가 얼마나 올라올지 또는 내려갈지를 설정합니다. 기본 값은 `12.0`입니다.
- toastHorizontalMargin: `CGFloat` 타입으로 토스트 뷰의 마진을 설정합니다. 기본 값은 `20.0`입니다.
- contentsHorizontalMargin: `CGFloat` 타입으로 토스트 내부 Horizontal 마진을 설정합니다. 기본 값은 `20.0`입니다.
- contentsVerticalMargin: `CGFloat`타입으로 토스트 내부 Vertical 마진을 설정합니다. 기본 값은 `12.0`입니다.

#### Example
``` swift
func showToast() {
  let toastLayout: ToastLayout = ToastLayout(
    imageSize: CGSize(width: 40, height: 40),
    imageLabelOffset: 0,
    toastOffset: 24,
    toastHorizontalMargin: 40.0,
    contentsHorizontalMargin: 0.0,
    contentsVerticalMargin: 0.0
  )
  
  Toast.showToast(
    message: "Toast With Custom Layout",
    image: UIImage(systemName: "heart.fill")!,
    layout: toastLayout
  )
}
```
<p align="left">
  <img src="https://github.com/Guboneui/Toast/assets/73548875/bf13f583-d260-4f64-8387-82576f209131" width=200>
</p>


---
### ToastAnimation
토스트의 애니메이션을 커스텀 할 수 있습니다.
- showDuringTime: `TimeInterval` 타입으로 토스트가 보여지기 까지의 애니메이션 시간을 지정합니다. 기본값은 `0.3초`입니다.
- showAnimation: `AnimationOptions` 타입입니다. 기본값은 `.curveEaseIn`입니다.
- waitTime: `TimeInterval` 타입으로 토스트 유지 시간입니다. 기본값은 `1.7초`입니다.
- hideDuringTime: `TimeInterval` 타입으로 토스트가 사라지기 까지의 애니메이션 시간을 지정합니다. 기본값은 `0.3초`입니다.
- hideAnimation: `AnimationOptions` 타입입니다. 기본값은 `.curveEaseOut`입니다.
- addAlphaEffect: `Bool` 타입으로 토스트 생성 시 alpha값을 0.0 -> 1.0 으로 변경할지 여부를 지정합니다. 기본값은 `true`입니다.
- completion: `(()->())?` 타입으로 토스트가 사라진 후 특정 액션이 필요한 경우 사용합니다. 기본값은 `nil`입니다.

#### Example
``` swift
func showToast() {
  let toastAnimation: ToastAnimation = ToastAnimation(
    showDuringTime: 1.0,
    showAnimation: .curveEaseInOut,
    hideDuringTime: 1.0,
    hideAnimation: .curveEaseInOut,
    completion: toastCompletion
  )
  
  Toast.showToast(
    message: "Toast With Custom Animation",
    animation: toastAnimation
  )
}
```
<p align="left">
  <img src="https://github.com/Guboneui/Toast/assets/73548875/cd5e8fef-d4a7-4d41-8afa-4b20c88d20b2" width=200>
</p>


---
### ETC
에러 및 요청 사항은 `starku2249@naver.com`으로 남겨주시면 수정 후 반영하도록 하겠습니다 :)
