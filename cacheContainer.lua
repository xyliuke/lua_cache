require("cache")

CacheContainer = {}
-- 存储所有cache数据，结构为type1:{key1=cache1, key2=cache2}
CacheContainer.data = {}

function CacheContainer:update(key, data, type)
	local getCacheByType = function(key, type)
		local map = self.data[type]
		local val = nil
		if map then
			val = map[key]
		else
			self.data[type] = {}
		end
		if val == nil then
			val = self:createCache(key, type)
			self.data[type][key] = val
		end
		return val
	end

	local cache = getCacheByType(key, type)
	cache:update(data)
	return cache
end

function CacheContainer:createCache(key, type)
	if type == cacheType["family"] then
		return FamilyCache.new(key)
	elseif type == cacheType["relative"] then
		return RelativeCache.new(key)
	elseif type == cacheType["bluetooth"] then
		return Bluetooth.new(key)
	end
	return nil
end

data = {name = "123", detail = {img = "456"}}
data1 = {name = "1234444"}

fc = CacheContainer:update("key1", data, cacheType["family"])
CacheContainer:update("key1", data1, cacheType["family"])
-- print(fc.key)
print_r(CacheContainer.data)

-- xxx = {["a"] = 1, ["b.c"] = 2}
-- for k,v in pairs(xxx) do
-- 	print(k,v)
-- end





