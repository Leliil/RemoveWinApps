# Windows 10/11 Built-in Apps Remover

![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?logo=powershell&logoColor=white)
![Batchfile](https://img.shields.io/badge/Batch-4D4D4D.svg?logo=windows-terminal&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

Утилита для массового удаления встроенных приложений Windows 10/11 на корпоративных устройствах.

## Установка

1. Склонируйте репозиторий:
```powershell
git clone https://github.com/Leliil/RemoveWinApps.git
```

2. Или скачайте ZIP-архив и распакуйте

## Использование

### Базовый запуск
```powershell
.\RemoveApps.bat
```

### Параметры
| Параметр       | Описание                          |
|----------------|-----------------------------------|
| /silent        | Тихий режим (без подтверждений)   |
| /skipreg       | Пропустить изменения реестра      |
| /customlist    | Использовать custom_apps.txt      |

### Для массового развертывания
```powershell
# Через групповые политики (GPO)
gpupdate /force
```

## Список удаляемых приложений
Скрипт удаляет более 30 встроенных приложений, включая:
- Xbox и игровые компоненты
- Cortana
- Microsoft Office Hub
- Bing приложения
- Skype
- Погода, Карты и другие

Полный список в файле скрипта [RemoveApps.bat](RemoveApps.bat)

## Технические детали
- Работает на Windows 10/11 (включая Enterprise LTSC)
- Требует прав администратора
- Поддерживает PowerShell 5.1+
- Не требует интернет-соединения

## Лицензия
MIT License - подробности в файле [LICENSE](LICENSE)

---

*Примечание:* Перед массовым развертыванием протестируйте скрипт на контрольной группе устройств!
