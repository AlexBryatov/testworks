-- Function for converting Lua table to LUA code text
-- Parameters: tabptr - table pointer
--             TabName - new table name in Lua code
function TabToLuaString(tabptr, TabName)

delim,a = '', TabName .. '={'

for k, v in pairs(tabptr) do
  if tonumber(k) ~= nil then
    a = a .. delim .. '[' .. tostring(k) .. '] = '
  else
    a = a .. delim ..  tostring(k) .. ' = '
  end

  if type(v) ~= "string" then
    a = a .. tostring(v)
  else
    a = a ..'\"'.. tostring(v)..'\"'
  end

  if delim == '' then delim = ', ' end
end -- for

return a .. ' }'
end  -- end of function TabToLuaString


-- Some tests of this function

tab1 = { k5='true', false, k1 = 1, k3 = 5 }
tab2 = { s123='123', true, s11 = 11, s13 = 13, 75, 76, 77, 78, 79, 80 }
tab3={}

s1 = TabToLuaString(tab1, 'T1')
print(s1)
s2 = TabToLuaString(tab2, 'T2')
print(s2)
s3=TabToLuaString(tab3, 'T3')
print(s3)

