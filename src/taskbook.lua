local Taskbook = {}
Taskbook.__index = Taskbook

local function trim(value)
    return (value:gsub('^%s+', ''):gsub('%s+$', ''))
end

function Taskbook.new(storagePath)
    local instance = {
        storagePath = storagePath or 'tasks.txt',
        tasks = {}
    }

    return setmetatable(instance, Taskbook)
end

function Taskbook:addTask(text)
    local normalized = trim(text or '')

    if normalized == '' then
        return false, 'Task text cannot be empty'
    end

    table.insert(self.tasks, {
        text = normalized,
        done = false
    })

    return true, #self.tasks
end

function Taskbook:listTasks()
    return self.tasks
end

function Taskbook:markDone(index, done)
    local task = self.tasks[index]

    if not task then
        return false, 'Task not found'
    end

    task.done = done ~= false
    return true
end

function Taskbook:removeTask(index)
    if not self.tasks[index] then
        return false, 'Task not found'
    end

    table.remove(self.tasks, index)
    return true
end

function Taskbook:save()
    local handle, err = io.open(self.storagePath, 'w')

    if not handle then
        return false, err
    end

    for _, task in ipairs(self.tasks) do
        local status = task.done and '[x]' or '[ ]'
        handle:write(status .. ' ' .. task.text .. '\n')
    end

    handle:close()
    return true
end

function Taskbook:load()
    local handle = io.open(self.storagePath, 'r')

    if not handle then
        return true
    end

    self.tasks = {}

    for line in handle:lines() do
        local status, text = line:match('^(%[[x ]%])%s*(.+)$')

        if status and text then
            table.insert(self.tasks, {
                text = trim(text),
                done = status == '[x]'
            })
        end
    end

    handle:close()
    return true
end

return Taskbook
