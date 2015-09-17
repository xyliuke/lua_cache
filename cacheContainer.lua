require("cache")

CacheContainer = {}
-- 存储所有cache数据，结构为type1:{key1=cache1, key2=cache2}
CacheContainer.data = {}

function CacheContainer:update(data, type, key)
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

	if key == nil then
		key = getKeyFromJSON(data, type)
	end
	local cache = getCacheByType(key, type)
	cache:update(data)
	return cache
end

function CacheContainer:createCache(key, type)
	if key == nil then
		return nil
	end
	if type == cacheType["family"] then
		return FamilyCache.new(key)
	elseif type == cacheType["relative"] then
		return RelativeCache.new(key)
	elseif type == cacheType["bluetooth"] then
		return Bluetooth.new(key)
	end
	return nil
end

data = {name = "123", detail = {img = "456"}, id = "key3"}
data1 = {name = "1234444"}

fc = CacheContainer:update(data, cacheType["family"])
CacheContainer:update(data1, cacheType["family"], fc.key)






