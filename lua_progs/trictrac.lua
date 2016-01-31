-- ���� � ��������-������

GameTab={ 0,0,0,0,0,0,0,0,0 }  -- ������� ����
IdxTab= { a1=1,a2=2,a3=3,b1=4,b2=5,b3=6,c1=7,c2=8,c3=9 }  -- ��������� ������� ��� ����� ����
Players={ 'Player1','Player2' }  -- ����� �������
PTypes={ 'h','h' }  -- ��� ������: h - human, m - machine  (�������� ��� ���������� ���������)
PChar={ 1,2 }  -- ������� "�����" �������:  1 - ��������, 2 - ������
Score={ 0,0 }  -- ������� �����
CName={ '��������', '������' }
SName={ 'a', 'b', 'c' }  -- ����� �����

-- �������

function DrawTable() -- ���������� �������
local s,i

print ('\n'..Players[1]..' ������ '..CName[PChar[1]].. ', '..Players[2]..' ������ '..CName[PChar[2]])
print ('���� '..Score[1]..' : '..Score[2])
print ('    1   2   3  ')
print ('  +---+---+---+')
  for s=1,3 do
    i=(s-1)*3+1
    print (SName[s]..' | '..GameTab[i]..' | '..GameTab[i+1]..' | '..GameTab[i+2]..' |')
--  print ('  | '..GameTab[i]..' | '..GameTab[i+1]..' | '..GameTab[i+2]..' |')
    print ('  +---+---+---+')
  end
end  -- function DrawTable()

function GetIdx(s1) -- �������� ������ ������ �� �����
local val=0

if s1=='end' then
  val=-1
else
  val=IdxTab[s1]
  if val==nil then
    val=0
  else
    if GameTab[val] ~= ' ' then
      print('������ ������')
      val=0
    end
  end
end
return val
end  -- GetIdx

function ChkTable() -- �������� �������. ����������: 1 - ������ '�', 2- ������ '0', 3 - �����, 0 - ���� �� ���������
local i, res
res=0
  for i=1,3 do -- �������� �����. � ����. �����
  res=TstLine(i)
  if res ~= 0 then break end
  end
  if res==0 then res=TstCells(1,5,9) end -- �������� ��������� 1
  if res==0 then res=TstCells(3,5,7) end -- �������� ��������� 2
  if res==0 then -- �������� ������� �� ������� ������ �����
  res=3
    for i=1,9 do
    if GameTab[i]==' ' then  res=0;  break  end
    end
  end
return res
end  -- ChkTable

function TstCells(a,b,c) -- �������� 3-� ����� �� ���������� � ��� ���������� ��������
local res,ch

ch=GameTab[a]
if ch~=' ' and ch==GameTab[b] and ch==GameTab[c] then
  if ch=='X' then res=1 else res=2 end
else
res=0
end
return res
end  -- TstCells

function TstLine (lnum) -- �������� ���� ����� �� ���������� �������� ���� �� � ����� �� ���
local res, x

x=(lnum-1)*3+1
res=TstCells(x,x+1,x+2) -- �������� �����. �����
if res==0 then res=TstCells(lnum,lnum+3,lnum+6) end-- �������� ����. �����

return res
end -- TstLine


-- ���� ���������

-- ������������� ������
for i=1,2 do PTypes[i]='h'; Score[i]=0 end
PChar[1]=1; PChar[2]=2

local cRes=0 -- ��������� ������� ����

-- ���� �������� ���������� � �������
--tt=0
--if tt==0 then
io.write ('������� ��� ������� ������ -> ')
Players[1]=io.read()
print ('������������, '..Players[1]..'!\n')
io.write ('������� ��� ������� ������ -> ')
Players[2]=io.read()
print ('������������, '..Players[2]..'!\n')
--end  --if tt==0

repeat  -- ����������� ���� ���� �� ������

print ('\n�������� ����!')
for i=1,9 do GameTab[i]=' ' end

cStep=PChar[1]  -- ���������� cStep ����������, ��� ���
repeat
DrawTable()
if PChar[cStep] == 1 then cChar='X' else cChar='0' end  -- cChar - ������� ������, ������� �������� � �������
  repeat
    io.write ('��� '..Players[cStep]..' -> ')
    cfield=string.lower(io.read())
    fnum=GetIdx(cfield)
    if fnum==0 then print ('��� ����������. ����������� ��������� ���� ����������� ������ ������') end
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
until cStep == 0  -- ����� ��������� ����

if cRes~=0 then  -- ������� ��������� ����
  DrawTable()
  if cRes==PChar[1] then
    print ('������� '..Players[1]..'!')
    Score[1]=Score[1]+1
  elseif cRes==PChar[2] then
    print ('������� '..Players[2]..'!')
    Score[2]=Score[2]+1
  elseif cRes==3 then
    print ('�����!')
    Score[1]=Score[1]+0.5
    Score[2]=Score[2]+0.5
  end
  print ('���� '..Score[1]..' : '..Score[2])
end  -- if cRes~=0

io.write ('���������� ���� (y/n)?')
  cSymbol=string.lower(io.read())
  if cSymbol~='y' then
  print ('���� ��������.')
  else
    print('������ �������� ������!')
    PChar[1],PChar[2]=PChar[2],PChar[1]
  end
until cSymbol~='y' -- ����� ������������ ����� ����
