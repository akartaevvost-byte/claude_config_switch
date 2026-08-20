# 🔄 Claude Code Configuration Switcher (`cl-sw`)

Интерактивная консольная TUI/CLI утилита для быстрого, плавного и удобного переключения конфигураций (профилей) **Claude Code**.

Работает глобально из любого терминала и любой рабочей директории. Не требует внешних зависимостей (чистый Python 3 стандартной библиотеки).

---

## ✨ Ключевые возможности

* 🚀 **Мгновенное переключение:** Вызов одной короткой командой (`cl-sw`) без необходимости вводить `python script.py`.
* 📺 **Плавный TUI интерфейс (Zero-Flicker):** 
  * Отрисовка без мерцания через двойную буферизацию и in-place позиционирование курсора (`\033[H`).
  * Изолированный экранный буфер (Alternate Screen Buffer) — не засоряет историю терминала и scrollback.
  * Навигация стрелками `↑` / `↓`, `j` / `k`, `w` / `s`, выбор `Enter` / `Space`, цифры `1`–`8` для быстрого перехода.
* 📦 **Многомодельные профили:** Каждый профиль настраивает полную связку моделей: **Opus**, **Sonnet**, **Haiku**, а также эндпоинт и параметры контекстного окна.
* ⚡ **Прямой CLI-режим:** Возможность переключения профилей одной строкой (`cl-sw zai-1m`) без захода в интерактивное меню.
* 💾 **Управление профилями:** Создание, редактирование, удаление пользовательских профилей прямо из меню.
* 🛡️ **Безопасность и бэкапы:** Автоматическое резервное копирование `settings.json` перед каждым изменением в `~/.claude/backups/`.
* 🧪 **Встроенная диагностика:** Быстрый тест соединения с текущим провайдером (`cl-sw test`).

---

## 📋 Предустановленные профили

| Профиль (`ID`) | Название | Endpoint / Окно | Модель Opus | Модель Sonnet | Модель Haiku |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`zai-1m`** | **Z.AI GLM-5.3 [1M Window]** | `https://api.z.ai/api/anthropic`<br>*(1M Auto Compact Window)* | `glm-5.3[1m]` | `glm-5.3[1m]` | `glm-4.7` |
| **`zai-standard`** | **Z.AI GLM-5.3 [Standard 128k]** | `https://api.z.ai/api/anthropic`<br>*(Стандартное окно)* | `glm-5.3` | `glm-4.7` | `glm-4.5-air` |
| **`vv-router`** | **VkusVill Router** | `https://vvchat.vkusvill.ru/red-mad-router` | `claude-opus-4-6` | `gpt-5.5-pro` | `gpt-5.5` |

---

## 🛠️ Установка

### Вариант 1: Быстрая установка через скрипт
```bash
git clone https://github.com/akartaevvost-byte/claude_config_switch.git
cd claude_config_switch
./install.sh
```

### Вариант 2: Ручная установка
Скопируйте `cl-sw` в директорию, находящуюся в вашем `$PATH` (например, `~/.local/bin`):
```bash
mkdir -p ~/.local/bin
cp cl-sw ~/.local/bin/cl-sw
chmod +x ~/.local/bin/cl-sw

# Создание удобных алиасов (опционально)
ln -sf ~/.local/bin/cl-sw ~/.local/bin/claude-config
ln -sf ~/.local/bin/cl-sw ~/.local/bin/claude-switch
ln -sf ~/.local/bin/cl-sw ~/.local/bin/cc-switch
```

Убедитесь, что `~/.local/bin` добавлен в ваш `PATH` в `~/.zshrc` или `~/.bashrc`:
```bash
export PATH="${HOME}/.local/bin:$PATH"
```

---

## 📖 Использование

### 1. Интерактивное меню (TUI)
Запустите утилиту без аргументов:
```bash
cl-sw
```

#### Управление в меню:
* `↑` / `↓` или `k` / `j` или `w` / `s` — перемещение по пунктам.
* `Enter` или `Пробел` — выбор пункта.
* Цифры `1`–`8` — быстрый выбор соответствующего пункта.
* `q` или `Esc` — выход / возврат.

```
╔════════════════════════════════════════════════════════════════════════════╗
║  🤖                 Claude Code Profile Manager                            ║
╚════════════════════════════════════════════════════════════════════════════╝

 Active Profile: Z.AI GLM-5.3 [1M Window]
 Endpoint:       https://api.z.ai/api/anthropic
 Opus Model:     glm-5.3[1m]
 Sonnet Model:   glm-5.3[1m]
 Haiku Model:    glm-4.7
 Context Window: 1000000  |  Effort: medium  |  Default Target: opus
 API Key:        96be...9Of
────────────────────────────────────────────────────────────────────────────

 Use ↑/↓ (Up/Down) or j/k to navigate, Enter to select, q/Esc to exit:

 ❯ 1. ⚡ Switch Profile / Preset   Quickly activate a configured profile
   2. 🔍 View Current Config       Inspect settings.json details and models
   3. ✏️  Edit Active Configuration Modify models, context window, API key, effort
   4. 💾 Save Active as New Profile Store current configuration under a custom name
   5. 🧪 Test Connection           Run a test ping with current settings
   6. 🗑️  Delete Custom Profile    Remove a user-created profile
   7. 🚀 Launch Claude Code        Run 'claude' immediately
   8. 🚪 Exit                      Quit the switcher
```

### 2. Прямой режим CLI
```bash
# Список всех доступных профилей
cl-sw list

# Переключение на конкретный профиль
cl-sw zai-1m
cl-sw zai-standard
cl-sw vv-router

# Просмотр текущей активной конфигурации
cl-sw current

# Проверка соединения (ping)
cl-sw test

# Справка по командам
cl-sw --help
```

---

## 📁 Структура конфигурационных файлов

* **`~/.claude/settings.json`** — основной конфигурационный файл Claude Code, в который утилита записывает активные переменные окружения (`env`) и настройки модели.
* **`~/.claude/profiles.json`** — файл базы сохранённых профилей.
* **`~/.claude/backups/settings.json.bak`** — автоматически обновляемая резервная копия конфигурации.

---

## 📄 Лицензия

MIT License. Свободно для использования и модификации.
