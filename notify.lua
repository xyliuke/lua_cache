
-- 向上层通知数据接口

-- 通知某一个值变化，参数分别为：记录的id、cachetype、属性名、旧值、新值
function notify(key, type, keypath, oldvalue, newvalue)
	print("notify key:" .. key .. ",\ttype:" .. type .. ",\tproperty:" .. keypath .. ",\told value:" .. (oldvalue or "nil") .. ",\tnew value:" .. (newvalue or "nil"))
end

-- 通知某数组变化，参数分别为：记录id，数组类型、旧数组、新数组。记录id为key中的type类型数组发生变化。key可以为nil，表示数组为没有上层
-- 数组类型参照manager.lua中manager_data_type值
function notify_array(key, type, old_array, new_array)
	print("nofity array key:" .. (key or "nil") .. ",\ttype:" .. type .. ",\told_array:" .. (old_array or "nil") .. ",\tnew_array" .. (new_array or "nil"))
end