# PhotoFrame (by Yegor Geronin)
Приложение для просмотра фотографий на плашете или телефоне.

[![](https://psv4.vkuseraudio.net/s/v1/d/CQ6PhVhcpuOuesxOI1ZUEYGVonBW80Tm6LrlGYRal5zxaHeI592rBDyxXVhqywC82M6FOCk_KVh82mi2dTFZOMrHx6nR5k_b2qAoelAHfUPE4BeCpBMF7g/Artboard_1.png)](http://geronin.com)

### Table of contents:
- Стек приложения
- Архитектура
- Паттерны
------------
#### Application stack

Приложение используется стандартные модули без использования сторонних pods.
Для работы с данными и для их кеширования используется **CoreData**.
Работа с UI - через **UIKit**. Вся верстка сделана кодом без использования ксибов.
В некоторых местах используется GCD для того, чтобы приложение не пролагивало при сохрании в БД или выгрузке из БД больших изображений.

------------
#### Architecture
Приложение написано под архитектуру **VIPER** (без использования Router из-за отсутствия большого количества экранов). Вся схему представлена на картинке ниже.

---
[![](https://psv4.userapi.com/c536132/u159803114/docs/d25/d13465b8828b/Untitled_Diagram_drawio-3.png?extra=8jaiXHYoRdRdJd3NFWxatDAG_MXkuBHpTXJJNpI8CI8IWymDQ1I58amHh6PxTplrP-wTm5MZrzWuYGsWYnOdT-wtfGYiYHh23CxQIoWT8kH-1SttPc8EhrOOeswLEGgwxTbxLkWuxOJcdzXRlRoMQTni)](http://https://www.raywenderlich.com/8440907-getting-started-with-the-viper-architecture-pattern)
---

Основным контроллером приложения является кастомный TabBarViewController, который наследуется от UITabBarController. У него есть 2 итема с контроллерами: ShowingViewController и PhotosViewController. Контроллеры образуют слой View.

У каждого из контроллеров есть Presenter, **на** которого у них strong ссылка и **у** которого на них - weak.

При работе с данными изображений. Используется ImageInfoInteractor, который через closures передает информацию о моделях ImageInfo из базы данных CoreData.

------------
#### Patterns

При работе над приложение использовались паттерны:
- **Factory**
- **State** *(был вырезан за ненадобностью и усложнением кода)*

Паттерн Factory используется для создания кастомных UIAlertController и UIViewController.
State  использовался на начальных этапах приложения для таблицы загруженных фотографий. Предполагалось, что будет 3 стейта через enum:
    enum State {
    	case loading
    	case error(customError: Error)
    	case showing(data: [ImageInfo])
    }
Но так как работы с сетью не происходит отпала необходимость в стейте loading, а error был сделан в виде алерта.

*Yegor Geronin*
*Очень хочет в Яндекс*
