# Bilet already kupil

Приложение, отображающее сроки отключения горячей воды.

Для того, чтобы получить данные, используется следующий метод API:
`https://api.gu.spb.ru/UniversalMobileService/classifiers/downloadClassifiers?classifiersId=4`

Ответ на запрос имеет следующий вид: 
```json
{
  "status": "result",
  "responseData": {
    "classifiers": [
      {
        "classifierId": 4,
        "classifierName": "График остановок ТЭЦ ТГК-1 2016г",
        "file": "UEsDBBQAAAAIAKWp2VAl0/j9MfcAAAwWOwAYAAA...",
        "version": "26"
      }
    ]
  },
  "expectedResponseDate": "12.08.2020"
}
```

Значение поля file представляет собой base64 encoded zip-архив. 
Необходимо его декодировать и разархивировать. 
Содержимое архива - массив объектов следующего вида:

```json
[
  {
    "Населенный пункт": "Санкт-Петербург",
    "Адрес жилого здания": "Краснопутиловская",
    "№ дома": "65",
    "корпус": "",
    "литер": "",
    "Период отключения ГВС": "22.06.2020-05.07.2020"
  },
  {
    "Населенный пункт": "Санкт-Петербург",
    "Адрес жилого здания": "Ветеранов",
    "№ дома": "47",
    "корпус": "",
    "литер": "",
    "Период отключения ГВС": "22.06.2020-05.07.2020"
  }
]
```

Для отображения данных реализован экран на UITableView.

Пример содержимого ячейки:
```
Санкт-Петербург
Краснопутиловская
дом 15 корпус 1 литер А
20 мая 2019 - 2 июля 2019
```

Если у дома отсутствует корпус и/или литер, надписи “корпус”/“литер” не должны отображаться.

Сделаны заглушки ошибок для случаев, если:
- нет интернета,
- произошла какая-то непредвиденная ошибка (например, в поле file пришло некорректное содержимое и не удалось его раскодировать или разархивировать).

Каждая из заглушек содержит кнопку "Попробовать еще", по нажатию на которую приложение пытается еще раз загрузить данные. Если данные загрузить не получилось, приложение показывает данные из кэша, сохраненные ранее в базу данных CoreData.

---

**Язык** - Swift.

**Минимальная поддерживаемая версия ОС** - iOS 10.

**Архитектура** - однонаправленная модификация VIP с использованием состояний и биндинга при помощи RxSwift.