# PhotoFrame (by Yegor Geronin)
Приложение для просмотра фотографий на плашете или телефоне.

[![](https://sun9-west.userapi.com/sun9-61/s/v1/ig2/qHzHVYTw-rLoPxfgNTC1BvJI1oddRES0uzxJG6lwweYBFz0gcdJkjS8WQy4MqxeOyJYECiJ7a0OmsAgN_DdByo_R.jpg?size=120x120&quality=96&type=album)](http://https://sun9-west.userapi.com/sun9-61/s/v1/ig2/qHzHVYTw-rLoPxfgNTC1BvJI1oddRES0uzxJG6lwweYBFz0gcdJkjS8WQy4MqxeOyJYECiJ7a0OmsAgN_DdByo_R.jpg?size=120x120&quality=96&type=album)

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
[![Architecture](https://sun9-west.userapi.com/sun9-47/s/v1/ig2/hxU4TLKAlJoIq53gxVOl97DEnPDCyWmUBO1ZykYvpfYZM5M3zNoXmx-59PypDp1oUjznIA-FoJGjCt8jUjtePLD9.jpg?size=1104x826&quality=96&type=album "Architecture")](https://sun9-west.userapi.com/sun9-47/s/v1/ig2/hxU4TLKAlJoIq53gxVOl97DEnPDCyWmUBO1ZykYvpfYZM5M3zNoXmx-59PypDp1oUjznIA-FoJGjCt8jUjtePLD9.jpg?size=1104x826&quality=96&type=albumhttp:// "Architecture")
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
