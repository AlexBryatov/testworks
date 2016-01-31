-- Игра в крестики-нолики

GameTab={ 0,0,0,0,0,0,0,0,0 }  -- игровое поле
IdxTab= { a1=1,a2=2,a3=3,b1=4,b2=5,b3=6,c1=7,c2=8,c3=9 }  -- индексная таблица для ячеек поля
Players={ 'Player1','Player2' }  -- имена игроков
PTypes={ 'h','h' }  -- тип игрока: h - human, m - machine  (закладка для расширения программы)
PChar={ 1,2 }  -- текущие "фишки" игроков:  1 - крестики, 2 - нолики
Score={ 0,0 }  -- таблица счета
CName={ 'крестики', 'нолики' }
SName={ 'a', 'b', 'c' }  -- имена строк

-- Функции

function DrawTable() -- прорисовка таблицы
local s,i

print ('\n'..Players[1]..' ставит '..CName[PChar[1]].. ', '..Players[2]..' ставит '..CName[PChar[2]])
print ('Счет '..Score[1]..' : '..Score[2])
print ('    1   2   3  ')
print ('  +---+---+---+')
  for s=1,3 do
    i=(s-1)*3+1
    print (SName[s]..' | '..GameTab[i]..' | '..GameTab[i+1]..' | '..GameTab[i+2]..' |')
--  print ('  | '..GameTab[i]..' | '..GameTab[i+1]..' | '..GameTab[i+2]..' |')
    print ('  +---+---+---+')
  end
end  -- function DrawTable()

function GetIdx(s1) -- получить индекс ячейки по имени
local val=0

if s1=='end' then
  val=-1
else
  val=IdxTab[s1]
  if val==nil then
    val=0
  else
    if GameTab[val] ~= ' ' then
      print('Ячейка занята')
      val=0
    end
  end
end
return val
end  -- GetIdx

function ChkTable() -- Проверка таблицы. Возвращает: 1 - победа 'Х', 2- победа '0', 3 - ничья, 0 - игра не закончена
local i, res
res=0
  for i=1,3 do -- проверка гориз. и верт. линий
  res=TstLine(i)
  if res ~= 0 then break end
  end
  if res==0 then res=TstCells(1,5,9) end -- проверка диагонали 1
  if res==0 then res=TstCells(3,5,7) end -- проверка диагонали 2
  if res==0 then -- проверка таблицы на наличие пустых ячеек
  res=3
    for i=1,9 do
    if GameTab[i]==' ' then  res=0;  break  end
    end
  end
return res
end  -- ChkTable

function TstCells(a,b,c) -- проверка 3-х ячеек на совпадение в них комбинации символов
local res,ch

ch=GameTab[a]
if ch~=' ' and ch==GameTab[b] and ch==GameTab[c] then
  if ch=='X' then res=1 else res=2 end
else
res=0
end
return res
end  -- TstCells

function TstLine (lnum) -- проверка двух линий на совпадение символов хотя бы в одной из них
local res, x

x=(lnum-1)*3+1
res=TstCells(x,x+1,x+2) -- проверка гориз. линии
if res==0 then res=TstCells(lnum,lnum+3,lnum+6) end-- проверка верт. линии

return res
end -- TstLine


-- Тело программы

-- инициализация таблиц
for i=1,2 do PTypes[i]='h'; Score[i]=0 end
PChar[1]=1; PChar[2]=2

local cRes=0 -- результат текущей игры

-- ввод исходных параметров с консоли
--tt=0
--if tt==0 then
io.write ('Введите имя первого игрока -> ')
Players[1]=io.read()
print ('Здравствуйте, '..Players[1]..'!\n')
io.write ('Введите имя второго игрока -> ')
Players[2]=io.read()
print ('Здравствуйте, '..Players[2]..'!\n')
--end  --if tt==0

repeat  -- Бесконечный цикл игры до отмены

print ('\nНачинаем игру!')
for i=1,9 do GameTab[i]=' ' end

cStep=PChar[1]  -- переменная cStep определяет, чей ход
repeat
DrawTable()
if PChar[cStep] == 1 then cChar='X' else cChar='0' end  -- cChar - текущий символ, который поставим в таблицу
  repeat
    io.write ('Ход '..Players[cStep]..' -> ')
    cfield=string.lower(io.read())
    fnum=GetIdx(cfield)
    if fnum==0 then print ('Ход невозможен. Попытайтесь повторить ввод правильного адреса ячейки') end
  until fnum~=0
  if fnum < 0 then
    cStep=0  -- End of game
  else
    GameTab[fnum]=cChar
    cRes=ChkTable()
      if cRes~=0 then
      cStep=0
      else
      cStep = 3 - cStep
      end
  end
until cStep == 0  -- конец единичной игры

if cRes~=0 then  -- выводим результат игры
  DrawTable()
  if cRes==PChar[1] then
    print ('Выиграл '..Players[1]..'!')
    Score[1]=Score[1]+1
  elseif cRes==PChar[2] then
    print ('Выиграл '..Players[2]..'!')
    Score[2]=Score[2]+1
  elseif cRes==3 then
    print ('Ничья!')
    Score[1]=Score[1]+0.5
    Score[2]=Score[2]+0.5
  end
  print ('Счет '..Score[1]..' : '..Score[2])
end  -- if cRes~=0

io.write ('Продолжить игру (y/n)?')
  cSymbol=string.lower(io.read())
  if cSymbol~='y' then
  print ('Игра окончена.')
  else
    print('Игроки меняются ролями!')
    PChar[1],PChar[2]=PChar[2],PChar[1]
  end
until cSymbol~='y' -- конец бесконечного цикла игры
