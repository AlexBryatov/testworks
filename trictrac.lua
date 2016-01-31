-- Игра в крестики-нолики

GameTab={ 0,0,0,0,0,0,0,0,0 }  -- Игровая таблица
IdxTab= { a1=1,a2=2,a3=3,b1=4,b2=5,b3=6,c1=7,c2=8,c3=9 }  -- индексная таблица
Players={ 'Player1','Player2' }  -- список игроков
PTypes={ 'h','h' }  -- тип игрока: h - human, m - machine  (пока не используется)
PChar={ 1,2 }  -- текущие "фишки" игроков:  1 - крестик, 2 - нолик
Score={ 0,0 }  -- счет игры
CName={ 'крестики', 'нолики' }
SName={ 'a', 'b', 'c' }  -- коды строк

-- Функции

function DrawTable() -- Прорисовка таблицы игры
local s,i

print ('\n'..Players[1]..' использует '..CName[PChar[1]].. ', '..Players[2]..' использует '..CName[PChar[2]])
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

function GetIdx(s1) -- получить индекс ячейки
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

function ChkTable() -- Проверка таблицы. Рез-т: 1 - победил 'X', 2- победил '0', 3 - ничья, 0 - игра не закончена
local i, res
res=0
  for i=1,3 do
  res=TstLine(i)
  if res ~= 0 then break end
  end
  if res==0 then res=TstCells(1,5,9) end -- диагональ 1
  if res==0 then res=TstCells(3,5,7) end -- диагональ 2
  if res==0 then -- проверка на пустые ячейки
  res=3
    for i=1,9 do
    if GameTab[i]==' ' then  res=0;  break  end
    end
  end
return res
end  -- ChkTable

function TstCells(a,b,c) -- проверка 3-х ячеек (линии или диагонали)
local res,ch

ch=GameTab[a]
if ch~=' ' and ch==GameTab[b] and ch==GameTab[c] then
  if ch=='X' then res=1 else res=2 end
else
res=0
end
return res
end  -- TstCells

function TstLine (lnum) -- Проверка линии
local res, x

x=(lnum-1)*3+1
res=TstCells(x,x+1,x+2) -- горизонталь
if res==0 then res=TstCells(lnum,lnum+3,lnum+6) end -- вертикаль

return res
end -- TstLine


-- Текст программы

-- Инициализация таблиц
for i=1,2 do PTypes[i]='h'; Score[i]=0 end
PChar[1]=1; PChar[2]=2

local cRes=0 -- тек. результат

-- Инициальзация имен
--tt=0
--if tt==0 then
io.write ('Имя первого игрока -> ')
Players[1]=io.read()
print ('Здравствуйте, '..Players[1]..'!\n')
io.write ('Имя второго игрока -> ')
Players[2]=io.read()
print ('Здравствуйте, '..Players[2]..'!\n')
--end  --if tt==0

repeat  -- "бесконечный" цикл игры

print ('\nНачало игры!')
for i=1,9 do GameTab[i]=' ' end

cStep=PChar[1]  -- текущий шаг
repeat
DrawTable()
if PChar[cStep] == 1 then cChar='X' else cChar='0' end  -- cChar - текущий символ (X или 0)
  repeat
    io.write ('Шаг '..Players[cStep]..' (a1..c3) -> ')
    cfield=string.lower(io.read())
    fnum=GetIdx(cfield)
    if fnum==0 then print ('Неверный код ячейки! Попробуйте ввести код повторно.') end
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
until cStep == 0 

if cRes~=0 then  -- проверка результата
  DrawTable()
  if cRes==PChar[1] then
    print ('Победил '..Players[1]..'!')
    Score[1]=Score[1]+1
  elseif cRes==PChar[2] then
    print ('Победил '..Players[2]..'!')
    Score[2]=Score[2]+1
  elseif cRes==3 then
    print ('Ничья!')
    Score[1]=Score[1]+0.5
    Score[2]=Score[2]+0.5
  end
  print ('Счет '..Score[1]..' : '..Score[2])
end  -- if cRes~=0

  repeat
    io.write ('Продолжить игру (y/n)?')
    cSymbol=string.lower(io.read())
  until cSymbol=='y' or cSymbol=='n'
  if cSymbol~='y' then
  print ('Игра окончена.')
  else
    print('\nИгроки меняются ролями!')
    PChar[1],PChar[2]=PChar[2],PChar[1]
  end
until cSymbol~='y' -- конец "бесконечного" цикла
