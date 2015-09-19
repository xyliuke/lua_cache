require("print")
require("stringify")


manager_data_type = {flist = "family_list", rlist = "relative_list"}

-- 登录管理类
login_manager = {}
login_manager.data = {}
function login_manager:login(callback)

end

-- 家庭管理类
family_manager = {}
family_manager.data = {}
function family_manager:getfamily(callback)
	fl = {"f1", "f2", "f3"}
	old_array = rawget(self.data, manager_data_type["flist"])
	table.insert(self.data, manager_data_type["flist"], f1)
end

-- 活动管理类
activity_manager = {}
activity_manager.data = {}




-- 将t2中的所有元素复制到t1中，如果t1中已经存在了相同的元素，则覆盖
function merge(t1, t2)
	if t2 and t1 then
		for k,v in pairs(t2) do
			if type(k) == "number" then
				print("is Number")
				table.insert(t1, v)
			else
				print("is string")
				rawset(t1, k, v)
			end
			
		end
	end
end

local function deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        -- as before, but if we find a table, make sure we copy that too
        if type(v) == 'table' then
            v = deepCopy(v)
        end
        copy[k] = v
    end
    return copy
end
