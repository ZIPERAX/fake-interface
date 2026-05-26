# Fake CEF interface for Arizona Role Play
*by chapo for QuincyNey*

## MoonLoader requirements
* mimgui
* Effil
* Requests

## Bundling using LuBu
* `./lubu.exe config.json`

## Taskbook (задачник)
В проект добавлен простой задачник, чтобы записывать задачи в файл `tasks.txt`.

Пример использования:

```lua
local Taskbook = require('src.taskbook')

local tasks = Taskbook.new('tasks.txt')
tasks:load()

tasks:addTask('Купить продукты')
tasks:addTask('Сделать домашнее задание')
tasks:markDone(1, true)
tasks:save()
```

Формат файла:
* `[ ] Текст задачи` — активная задача
* `[x] Текст задачи` — выполненная задача
