require("defclass")
require("print")

function inArray(array, value)
	for k,v in pairs(array) do
		if v == value then
			return true
		end
	end
	return false
end

-- cache的类型
cacheType = {none = 0, relative = 1, family = 2, bluetooth = 3}
-- cache的基类
cache = class()
cache.key = nil
cache.type = nil
cache.properties = {}

function cache:ctor(key)
	self.key = key
end
-- 通知函数
function cache:nofity(name, oldValue, newValue)
	assert(self.key, "the key is nil")
	assert(self.type, "the type is nil")
	print("nofity key:" .. self.key .. ",\ttype:" .. self.type .. ",\tproperty:" .. name .. ",\told value:" .. (oldValue or "nil") .. ",\tnew value:" .. (newValue or "nil"))
end
-- 赋值函数，通过这个函数给属性赋值，并通知出去变化
function cache:setValue(property, value)
	if inArray(self.properties, property) then
		old = rawget(self, property)
		if value ~= old then
			rawset (self, property, value)
			self:nofity(property, old, value)
		end
	else
		assert(nil, "property list can not contain " .. property)
	end
end
-- 将json转换成类属性
function cache:update(data)
	self:setProperty(data)
end

function cache:setProperty(data)
	for k,v in pairs(self.properties) do
		local val, exist = getValueFromTable2(data, k)
		if exist then
			rawset(self, v, val)
		end
	end
end

-- 家庭类
FamilyCache = class(cache)
function FamilyCache:ctor(key)
	self.type = cacheType["family"]
	-- 家庭名/家庭头像
	self.properties = {["name"] = "name", ["detail.img"] = "img"}
end



-- 个人类
RelativeCache = class(cache)
function RelativeCache:ctor(key)
	self.key = key
	self.type = cacheType["relative"]
	-- 姓名/头像/手机号
	self.properties = {"name", "img",  "phone"}
end

-- 蓝牙设备
Bluetooth = class(cache)
function Bluetooth:ctor(key)
	self.key = key
	self.type = cacheType["bluetooth"]
	-- 姓名/头像/手机号
	self.properties = {"name", "img"}
end


-- 从tbl中获取key的值，key为字符串，可以使用层次表示法，如"a.b.c"，如果b下没有c,则返回nil
function getValueFromTable2(tbl, format)

	if tbl == nil or format == nil then
		return nil, false
	end

	local ret = tbl

	local index = 0
	local bindex = -1
	local eindex = -1
	bindex, eindex = string.find(format, "%.")

	while bindex and eindex do
		local key = string.sub(format, index, bindex - 1)
		local val = rawget(ret, key)
			if val then
				ret = val
			else
				return nil, false;
			end
		index = eindex + 1
		bindex, eindex = string.find(format, "%.", bindex + 1)
	end
	if index <= string.len(format) then
		local key = string.sub(format, index, string.len(format))
		return rawget(ret, key), true
	end
	return ret, false;
end

