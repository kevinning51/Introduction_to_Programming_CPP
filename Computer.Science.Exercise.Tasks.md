**Задача 1.** (*ЛАБИРИНТ*) Дадена е правоъгълна символна матрица <img src="https://latex.codecogs.com/svg.latex?\Large&space;A"> с размери <img src="https://latex.codecogs.com/svg.latex?\Large&space;N">x<img src="https://latex.codecogs.com/svg.latex?\Large&space;M">, която представлява „лабиринт“. Лабиринта се състои единствено от символите <img src="https://latex.codecogs.com/svg.latex?\Large&space;*">,$ и празната клетка.
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;*"> е лава, през която не може да се премине и върху която не може да се стъпи;
- $ е съкровище;
- празната клетка е проходим път.

В лабиринта може да се движим само на север, на изток, на юг и на запад (забранено е диагонално движение като например североизток). Да се напише функция, която:

а) проверява дали от дадена стартова позиция в лабиринта, с координати <img src="https://latex.codecogs.com/svg.latex?\Large&space;(x,y)">, може да се достигне до съкровище;

б) намира броя на всички съкровища, до които може да се достигне от дадена стартова позиция с координати <img src="https://latex.codecogs.com/svg.latex?\Large&space;(x,y)">.
 
Пример: На фигурата по-долу съществува път до съкровище от позиция с координати **(4,1)**, но не и от позиция с координати **(0,0)**. Също така, броя на съкровищата, до които може да се достигне от позиция с координати **(4,1)** е **3**, а от позиция с координати **(2,0)** е **1**.

<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|$|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">| |
---- | ---- | ---- | ---- | ---- |
<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">| |**$**| | |
**$**|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">| |
<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">| | | | |
| | |<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|<img src="https://latex.codecogs.com/svg.latex?\Large&space;*">|**$**|

*автор: Трифон Трифонов*

***Решение:***

**а)**
```cpp
#include <iostream>

const int MAX = 100;

char labyrinth[MAX][MAX] = {
	"*$** ",
	"* $  ",
	"$*** ",
	"*    ",
	"  **$"
};

const int WIDTH = 5;
const int HEIGHT = 5;

void printPoint(char const* text, int x, int y)
{
	std::cout << text << " (" << x << ',' << y << ")\n";
}
void printLabyrinth()
{
	for (int i = 0; i < HEIGHT; i++)
	{
		std::cout << labyrinth[i] << std::endl;
	}
}
bool findTreasure(int x, int y)
{
	printPoint("We try to step at", x, y);
	if (x < 0 || y < 0 || x >= HEIGHT || y >= WIDTH || labyrinth[x][y] == '*')
	{
		printPoint("We cannot step at", x, y);
		return false;
	}
	if (labyrinth[x][y] == '"')
	{
		printPoint("We have already been at", x, y);
		return false;
	}
	if (labyrinth[x][y] == '$')
	{
		printPoint("We found treasure at", x, y);
		return true;
	}
	// 0 <= x < HEIGHT && 0 <= WIDTH && labyrinth[x][y] == ' '
	printPoint("We step at", x, y);
	labyrinth[x][y] = '"';
	//north
	if (findTreasure(x - 1, y))
	{
		printPoint("The journey goes through", x - 1, y);
		return true;
	}
	//east
	if (findTreasure(x, y + 1))
	{
		printPoint("The journey goes through", x, y + 1);
		return true;
	}
	//south
	if (findTreasure(x + 1, y))
	{
		printPoint("The journey goes through", x + 1, y);
		return true;
	}
	//west
	if (findTreasure(x, y - 1))
	{
		printPoint("The journey goes through", x, y - 1);
		return true;
	}
	printPoint("We are stepping back from", x, y);
	labyrinth[x][y] = 'X';
	return false;
}
int main()
{
	printLabyrinth();
	std::cout << findTreasure(4, 1) << std::endl;
	printLabyrinth();
	return 0;
}
```
**б)**
```cpp
#include <iostream>

const int MAX = 100;

char labyrinth[MAX][MAX] = {
	"*$** ",
	"* $  ",
	"$*** ",
	"*    ",
	"  **$"
};

const int WIDTH = 5;
const int HEIGHT = 5;

void printPoint(char const* text, int x, int y)
{
	std::cout << text << " (" << x << ',' << y << ")\n";
}
void printLabyrinth()
{
	for (int i = 0; i < HEIGHT; i++)
	{
		std::cout << labyrinth[i] << std::endl;
	}
}
int findAllTreasures(int x, int y)
{
	printPoint("We try to step at", x, y);
	if (x < 0 || y < 0 || x >= HEIGHT || y >= WIDTH || labyrinth[x][y] == '*')
	{
		printPoint("We cannot step at", x, y);
		return 0;
	}
	if (labyrinth[x][y] == '"')
	{
		printPoint("We have already been at", x, y);
		return 0;
	}
	int foundTreasures = 0;
	if (labyrinth[x][y] == '$')
	{
		printPoint("We found treasure at", x, y);
		foundTreasures = 1;
	}
	// 0 <= x < HEIGHT && 0 <= y < WIDTH && labyrinth[x][y] == ' '
	printPoint("We step at", x, y);
	labyrinth[x][y] = '"';
	foundTreasures += findAllTreasures(x - 1, y);//north	
	foundTreasures += findAllTreasures(x, y + 1);//east
	foundTreasures += findAllTreasures(x + 1, y);//south
	foundTreasures += findAllTreasures(x, y - 1);//west
	printPoint("We stepping back from", x, y);
	labyrinth[x][y] = 'X';
	return foundTreasures;
}
int main()
{
	printLabyrinth();
	std::cout << findAllTreasures(4, 1) << std::endl;
	printLabyrinth();
	return 0;
}
```
**Задача 2.** (*ВАРИАЦИИ*) Да се образуват всички <img src="https://latex.codecogs.com/svg.latex?\Large&space;n"> - мерни вектори с компоненти 0 и 1.

Например, при <img src="https://latex.codecogs.com/svg.latex?\Large&space;n=3"> всички 3-мерни вектори с компоненти 0 и 1 са:
- (0,0,0)
- (0,0,1)
- (0,1,0)
- (0,1,1)
- (1,0,0)
- (1,0,1)
- (1,1,0)
- (1,1,1)

Задачата да се реши по два начина:

а) с помощта на бинарни оператори и представянето на всяко число в двоична бройна система;

б) без да се използват бинарни оператори.

***Решение:***

За решаването на тази задача трябва да се образуват всички вариации (*комбинации с повторения*) на числата 0 и 1 от <img src="https://latex.codecogs.com/svg.latex?\Large&space;n">-ти клас. За целта ще използваме операцията **събиране на вектори по модул 2**. В подточка а) това събиране може да се замести от побитовия оператор &, но в подточка б) нямамв право да използваме такива. За нея ще трябва да напишем как работи оператора.

**Дефиниция**. Нека <img src="https://latex.codecogs.com/svg.latex?\Large&space;a=(a_1,a_2,...,a_n)"> e произволен <img src="https://latex.codecogs.com/svg.latex?\Large&space;n">-мерен вектор с компоненти 0 и 1. **Сумата по модул 2** на вектора <img src="https://latex.codecogs.com/svg.latex?\Large&space;a"> с <img src="https://latex.codecogs.com/svg.latex?\Large&space;n">-мерния единичен вектор <img src="https://latex.codecogs.com/svg.latex?\Large&space;e=(0,0,...,0,1)"> е вектор <img src="https://latex.codecogs.com/svg.latex?\Large&space;a'=(a_1',a_2',...,a_n')">, чиито компоненти се образуват съгласно следните правила:
- ако <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_n=0">, то 
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_i'=a_i,i-1,2,...,n-1"> 
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_n'=1">.
- ако <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_n=a_{n-1}=...=a_{m+1}=1,a_m=0,1\le{m}<n">, то 
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_i'=a_i,i=1,...,m-1">
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_m'=1">
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_i'=0,i=m+1,...,n">
- ако <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_1=a_2=...=a_n=1">, то 
  - <img src="https://latex.codecogs.com/svg.latex?\Large&space;a_1'=a_2'=...=a_n'=0">

**а)**

```cpp
#include <iostream>
#include <cmath>
void bin(unsigned n,unsigned k)
{
	unsigned i;
	std::cout << '(';
	for (i = 1 << k-1; i > 0; i = i / 2)
	{
		(n & i) ? std::cout << "1" : std::cout << "0";
		if (i != 1)
		{
			std::cout << ',';
		}
	}
	std::cout << ')';
}

int main()
{
	unsigned n;
	std::cin >> n;
	for (size_t i = 0; i < pow(2,n); i++)
	{
		bin(i,n);
		std::cout << std::endl;
	}
	return 0;
}
```

**б)**

```cpp
#include <iostream>
#include <cmath>
void printArr(int* a, size_t n)
{
	for (size_t i = 0; i < n; i++)
	{
		std::cout << a[i] << ' ';
	}
	std::cout << std::endl;
}
int main()
{
	size_t n, m;
	std::cout << "n = ";
	std::cin >> n;

	int a[30];

	for (size_t i = 0; i < n; i++)
	{
		a[i] = 0;
	}
	for (size_t i = 0; i < pow(2,n); i++)
	{
		if (a[n]==0)
		{
			a[n] = 1;
			printArr(a, n);
		}
		else
		{
			m = n;
			while (a[m] == 1)
			{
				m = m - 1;
			}
			a[m] = 1;
			for (size_t i = m+1; i < n; i++)
			{
				a[i] = 0;
			}
			printArr(a, n);
		}
	}
	return 0;
}
```