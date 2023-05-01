:warning: WIP

<div align="center">

  <img src="https://user-images.githubusercontent.com/43297314/235433087-aba0e80a-aced-4cc5-ae3d-5a7745f3a671.png" height="256" alt="information kit logo">
  <h1 align="center">InformationKit</h1>
InformationKit is a Swift library used to display small banners with app update information within your own application. It enables users to stay up-to-date with the latest version of the app.

  <a href="https://www.buymeacoffee.com/swiftdev" target="_blank"><img src="https://user-images.githubusercontent.com/43297314/167192051-dc8cfd47-1c2d-43f1-bb95-275ae70ef8dd.svg" alt="Buy Me coffee" ></a>



<img src="https://user-images.githubusercontent.com/43297314/235515840-b9176372-1f0e-48fd-9597-99adfcfe7c64.png" alt="app window" width="320"> &nbsp;
<img src="https://user-images.githubusercontent.com/43297314/235528456-228ea1ce-e788-4dfc-b925-cca420200aff.png" width="320">
</div>



### Usage
InformationKit is extremely easy to integrate. You don't need to pass any variables, or set any parameters from your view. Just modify your **info.plist** and add `InformationSourceURL` and `InformationSortType` keys and done.
```xml
<!--index, random or prioritized-->
<key>InformationSortType</key>
<string>prioritized</string>

<!--remote config URL-->
<key>InformationSourceURL</key>
<string>https://aayush9029.github.io/Armed/news/config.json</string>
```

```swift
import InformationKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        InformationBanner()
    }
}
```
