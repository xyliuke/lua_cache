require("cache")
require("stringify")
require 'busted.runner'()

cache_container = {}
-- 存储所有cache数据，结构为type1:{key1=cache1, key2=cache2}
cache_container.data = {}

function cache_container:update(data, type, key)
	local getCacheByType = function(key, type)
		local map = self.data[type]
		local val = nil
		if map then
			val = map[key]
		else
			self.data[type] = {}
		end
		if val == nil then
			val = self:create_cache(key, type)
			assert(val, "the cache can not create")
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

function cache_container:create_cache(key, type)
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


describe("cache_container #cache", function()
	data = {name = "123", detail = {img = "456"}, id = "key3"}
	data1 = {name = "1234444"}	
	local fc = cache_container:update(data, cacheType["family"])
	cache_container:update(data1, cacheType["family"], fc.key)

	print(stringify(fc))
	
	

	it("tests expose block updates", function()
	    assert.is_true(fc.key == "key3")	
	end)
	it("tests expose block updates environment", function()
	    assert.is_true(fc.name == "1234444")
	end)
end)











