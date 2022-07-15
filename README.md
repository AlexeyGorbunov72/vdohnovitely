## Сгенерить так


```
tuist fetch
tuist generate
```

## Combine

Добавил паблишер на UIControl
```swift
button
    .publisher(for: .touchUpInside)
    .sink {
        ...
    }
    .store(in: &disposable) // тип если ты внутри наследника NSObject то disposable тут уже есть не надо новый создавать
```

```swift
textField
    .publisher(for: .editingChanged)
    .sink {
        ...
    }
    .store(in: &disposable)
```
и в NSObject проперти `disposable: Set<AnyCancellable>` и теперь можно не добавлять по кд это приватное проперти
## UserDefaults

Взял решение [Алмаза](https://medium.com/@almazrafi/key-value-containers-7a8312a7e432) и теперь можно писать так:

```swift
extension UserDefaults {
    var labelTitle: KeyValueContainer<String> { make() }
}
...
UserDefaults.standard.labelTitle.value = "Текст"
button.setTitle(UserDefaults.standard.labelTitle.value, for: .normal)
```

## Легендарнейший экстеншен на UIViewController 👏

```swift
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
```

## Навигация камминг сун...
