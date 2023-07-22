--This is truely amazing

local newcclosure = function(func)
	return coroutine.wrap(function(...)
		while true do
			coroutine.yield(func(...))
		end
	end)
end

local hookfunction = function(...)
	local OldFunction = select(1, ...)
	local NewFunction = select(2, ...)

	if debug.info(OldFunction, "s") == "[C]" then
		OldFunction = newcclosure(NewFunction)
	else
		OldFunction = NewFunction
	end

	return OldFunction
end

local hookmetamethod = function(...)
	local Object = select(1, ...)
	local Metamethod = select(2, ...)
	local Function = select(3, ...)

	return hookfunction(getrawmetatable(Object)[Metamethod], newcclosure(Function))
end

getgenv().hookmetamethod = hookmetamethod;
getgenv().hookfunction = hookfunction;
getgenv().newcclosure = newcclosure;
