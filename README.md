# Windows 10/11 Built-in Apps Remover

![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-10/11-0078D6.svg?logo=windows)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

Утилита для массового удаления встроенных приложений Windows 10/11 в корпоративных средах.

## Особенности
- Удаление приложений для всех пользователей (включая будущих)
- Блокировка автоматической переустановки через Microsoft Store
- Работа в изолированных сетях (без интернета)
- Поддержка Windows 10 и 11 (включая Enterprise LTSC)

## Блокировка Microsoft Store
По умолчанию скрипт не отключает Microsoft Store, но добавляет политики, предотвращающие автоматическую установку приложений.

**Зачем это нужно?**
1. Некоторые встроенные приложения могут автоматически переустанавливаться через Store
2. Store использует трафик для обновлений
3. Повышает безопасность (ограничение неконтролируемых установок)

**Как включить полную блокировку Store?**
Добавьте в конец скрипта:
```batch
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f
```

## Установка
```powershell
git clone https://github.com/ваш-репозиторий.git
cd windows-apps-remover
```

## Использование
### Базовый запуск
```powershell
.\RemoveApps.bat
```

### Параметры
| Параметр       | Описание                          |
|----------------|-----------------------------------|
| /strict        | Блокирует Microsoft Store         |
| /keepstore     | Не трогать Store (по умолчанию)   |
| /list          | Показать список удаляемых приложений |

### Для Windows 11
```powershell
.\RemoveApps.bat /strict
```

## Список удаляемых приложений
| Категория       | Примеры приложений                |
|----------------|-----------------------------------|
| Игровые        | Xbox, Solitaire                   |
| Офисные        | Office Hub, OneNote               |
| Мультимедиа    | Movies & TV, Groove Music         |
| Windows 11     | Clipchamp, Teams                  |

[Полный список](RemoveApps.bat)

## Технические детали
- **Требования**: 
  - Windows 10/11
  - PowerShell 5.1+
  - Права администратора

- **Реестр**:  
  Изменяет ключи в HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent

## Лицензия
MIT License - [подробности](LICENSE)

> Важно: Перед массовым развертыванием протестируйте в пилотной группе!
