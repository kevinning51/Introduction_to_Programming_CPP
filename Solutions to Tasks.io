//Task 1
#include <iostream>
void swap(int& a, int& b)
{
	int temp = a;
	a = b;
	b = temp;
}
int main()
{
	int a, b;
	std::cin >> a >> b;

	std::cout << a << ", " << b << "\n";
	swap(a, b);
	std::cout << a << ", " << b << "\n";
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 2
#include <iostream>
#include <cmath>
size_t tri(double a, double b, double c)
{
	bool x = (a <= 0) || (b <= 0) || (c <= 0) ||
		(a + b <= c) || (a + c <= b) || (b + c <= a);
	if (x) return 0;
	else if ((a == b) && (b == c))return 3;
	else if ((a == b) || (b == c) || (c == a)) return 2;
	else return 1;	
}
int main()
{
	double a, b, c;
	std::cin >> a >> b >> c;

	switch (tri(a,b,c))
	{
	case 0:
		std::cout << "Such triangle with sides a,b,c don't exist";
		break;
	case 1:
		std::cout << "Scalene";
		break;
	case 2:
		std::cout << "Isosceles";
		break;
	case 3:
		std::cout << "Еquilateral";
		break;
	default:
		break;
	}
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 3 
#include <iostream>
#include <cmath>
int main()
{
	double x, y, k;
	std::cin >> x >> y;
	if (x*y == 0)
	{
		if (x == y) std::cout << "Point P(" << x << ',' << y << ") matches point O(0,0).";
		else
		{
			if (x > 0) std::cout << "Point P(" << x << ',' << y << ") lies on the abscissa.";			
			else std::cout << "Point P(" << x << ',' << y << ") lies on the ordinate.";			
		}
		return 0;
	}
	else
	{
		if (x*y > 0)
		{
			if (x > 0) k = 1;
			else k = 3;
		}
		else
		{
			if (x > 0) k = 4;
			else k = 2;
		}
	}
	std::cout << "Point P(" << x << ',' << y << ") lies in the "<<k<< " quadrant.";
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 4
#include <iostream>
long long absVal(long long n)
{
	return n < 0 ? -n : n;
}
int main()
{
	long long n;
	std::cin >> n;
	size_t count(0), sum(0);
	long long num = absVal(n);

	while (num != 0)
	{
		sum += num % 10;
		num /= 10;
		count++;
	}

	std::cout.setf(std::ios::fixed);
	std::cout.precision(2);
	std::cout << sum / (double)count;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 5
#include <iostream>
size_t myStrLen(const char* str)
{
	size_t len;
	for (len = 0; str[len] != '\0'; len++) {}
	return len;
}
bool isDigit(const char symbol)
{
	return (symbol >= '0' && symbol <= '9');
}
bool checkDate(const char* text)
{
	size_t len = myStrLen(text);
	if (len != 5) return false;
	if (!isDigit(text[0]) || !isDigit(text[1])) return false;
	if (text[2] != '.') return false;
	if (!isDigit(text[3]) || !isDigit(text[4])) return false;

	size_t days = (text[0] - '0') * 10 + text[1] - '0';
	size_t months = ((text[3] - '0') * 10 + text[4] - '0');
	if (months < 1 || months>12) return false;
	size_t maxDaysPerMonth[] =
	{
		0,
		31, 29, 31, 30, 31, 30,
		31, 31, 30, 31, 30, 31
	};
	return days <= maxDaysPerMonth[months];
}
int main()
{
	const char* str1 = "22.12";
	const char* str2 = "31.02";
		
	std::cout << checkDate(str1)<<std::endl;
	std::cout << checkDate(str2) << std::endl;

	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 6
#include <iostream> 
size_t strLen(const char* text)
{
	size_t len;
	for (len = 0; text[len] != '\0'; len++) {}
	return len;
}
int subString(const char* subStr, const char* str)
{
	size_t lenSubStr = strLen(subStr);
	size_t lenStr = strLen(str);
	if (lenSubStr > lenStr) return -1;

	for (size_t i = 0; i <= lenStr - lenSubStr; i++) {
		size_t j;
		/* For current index i, check for pattern match */
		for (j = 0; j < lenSubStr; j++)
			if (str[i + j] != subStr[j])
				break;
		if (j == lenSubStr)
			return i;
	}
	return -1;
}
int main()
{
	const char* s1 = "hub";
	const char* s2 = "www.github.com";
	int res = subString(s1, s2);
	if (res == -1) std::cout << "Not present";
	else std::cout << "Present at index " << res;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 7 
#include <iostream>
#include <cmath>
size_t numLen1(long long num)
{ // first way using log10 function
	size_t len = size_t(floor(log10(abs(num)))) + 1;
	return len;
}
size_t numLen2(long long n)
{ // second way with counting
	size_t len = 0;
	while (n != 0)
	{
		n /= 10;
		len++;
	}
	return len;
}
long long revNum(long long n)
{
	long long r = 0;
	size_t len = numLen1(n);
	while (len != 0)
	{
		r += (long long)((n % 10)*pow(10, len - 1));
		n /= 10;
		len--;
	}
	return r;
}
int digitPos1(long long num, int k)
{ // first way (without reverting the number)
	int len = numLen2(num);
	num = abs(num);
	int endCycle = len - k;
	int digit = -1;
	if (k > len || k < 1) return -1;
	for (int i = len - 1; i >= endCycle; i--)
	{
		digit = (size_t)(num / pow(10, i));
		long long denom = (long long)(pow(10, len - 1));
		num = num % denom;
		len--;
	}
	return digit;
}
int digitPos2(long long num, int k)
{ // second way with reverting the number
	size_t len = numLen2(num);
	long long rev = revNum(num);
	num = abs(rev);
	int digit = -1;
	if (k > (int)len || k < 1)return digit;
	size_t i(0);
	while (i != k)
	{
		digit = num % 10;
		num /= 10;
		i++;
	}
	return digit;
}
int main()
{
	long long n;
	std::cin >> n;
	for (size_t i = 1; i <= numLen1(n); i++) std::cout << digitPos1(n, i) << ' ' << digitPos2(n, i) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 8
#include <iostream>
size_t strLen(char* text)
{	
	size_t len;
	for ( len= 0; text[len] != '\0'; len++){}
	return len;
}
void revert(char* text)
{
	size_t len = strLen(text);
	for (size_t i = 0; i < len; i++)
	{
		bool isCapital = text[i] >= 'A' && text[i] <= 'Z';
		bool isLowercase = text[i] >= 'a' && text[i] <= 'z';
		text[i] += isCapital * 32 + isLowercase * (-32);
	}
}
int main()
{
	char text[10] = "asd&ASD";
	std::cout << text << std::endl;
	revert(text);
	std::cout << text << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 9
#include <iostream>
double sqrt_x(double x, double eps)
{ // Babylonian method
	double s = x;
	while ((s - x / s) > eps) s = (s + x / s) / 2;
	return s;
}
int main()
{
	std::cout << sqrt_x(2, 0.000001) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 10
#include <iostream>
double karPow(double x, int n)
{ // Karatsuba algorithm
	if (n == 0)		return 1;
	if (n == 1)		return x;
	if (n > 0)
	{
		if (n % 2 == 0) return karPow(x, n / 2)*karPow(x, n / 2);
		else return x * karPow(x, n - 1);
	}
	else return 1 / karPow(x, abs(n));	
}
int main()
{
	std::cout << karPow(3, -2) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 11
#include <iostream>

int countWords(char* text)
{
	for (size_t i = 0; text[i] != '\0'; i++)
	{
		int count = 0;
		bool inWord = false;
		for (size_t i = 0; text[i] != '\0'; i++)
		{
			if (text[i] != '\t'&&text[i] != '\n'&&text[i] != ' ')
			{
				if (!inWord) count++;				
				inWord = true;
			}
			else inWord = false;
		}
		return count;
	}
	return-1;
}
int main()
{
	char text[20] = " git\thub\n ";
	std::cout << countWords(text) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 12
#include <iostream>
#include <cmath>
#include <string>
void swap(char& a, char& b)
{
	char temp = a;
	a = b;
	b = temp;
}
void reverse(std::string& str)
{
	size_t len = str.length();
	for (size_t i = 0; i < len / 2; i++)
		swap(str[i], str[len - i - 1]);
}
std::string convNum(long long n, size_t m)
{
	std::string zero = "0";
	if (n == 0) return zero;
	std::string num("");
	bool isNegative = false;
	if (n < 0) isNegative = true;
	n = abs(n);

	size_t i = 0;
	while (n != 0)
	{
		int rem = n % m;
		if (rem <= 9) num += rem + '0';
		else num += (char)(rem)+'7';
		n /= m;
	}
	if (isNegative) num += '-';
	reverse(num);
	return num;
}
int main()
{
	long long n;
	std::cin >> n;
	std::cout << "Decimal: " << n
		<< "\nBinary: " << convNum(n, 2)
		<< "\nOct: " << convNum(n, 8)
		<< "\nHex: " << convNum(n, 16) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 13 
#include <iostream>
#include <cmath>
size_t fib1(size_t n)
{ // first way - using recursion
	if (n == 0) return 0;
	if (n == 1) return 1;
	else return fib1(n - 1) + fib1(n - 2);
}
size_t fib2(size_t n)
{ // second way - solving the characteristical polynomial of the sequence
	double root1 = (1 + sqrt(5)) / 2;
	return (size_t)((pow(root1, n) - 1 / pow(-root1, n))/sqrt(5));
}
size_t fib3(size_t n)
{ // third way - cycling
	size_t f1(0), f2(1), f3;
	if (n == 0)	return f1;
	for (size_t i = 2; i <= n; i++)
	{
		f3 = f2 + f1;
		f1 = f2;
		f2 = f3;
	}
	return f2;
}
int main()
{
	size_t n;
	std::cin >> n;
	std::cout << fib1(n) << std::endl;
	std::cout << fib2(n) << std::endl;
	std::cout << fib3(n) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------
//Task 14 
#include <iostream>
#include <cmath>
size_t seq1(size_t n)
{ // first way - using recursion
	if (n == 0) return 0;
	if (n == 1) return 1;
	else return (size_t)(5 * seq1(n - 1) - 6 * seq1(n - 2) + pow(6, n - 2));
}
size_t seq2(size_t n)
{ // second way - solving the characteristical polynomial of the sequence
	size_t result = (size_t)(-3.0 / 4 * pow(2, n) + 2.0 / 3 * pow(3, n) + 1.0 / 12 * pow(6, n));
	return result;
}
size_t seq3(size_t n)
{ // third way - cycling
	size_t a0(0), a1(1), a2;
	if (n == 0)	return a0;
	for (size_t i = 2; i <= n; i++)
	{
		a2 = (size_t)(5 * a1 - 6 * a0 + pow(6, i-2));
		a0 = a1;
		a1 = a2;
	}
	return a1;
}
int main()
{
	size_t n;
	std::cin >> n;
	std::cout << seq1(n) << std::endl;
	std::cout << seq2(n) << std::endl;
	std::cout << seq3(n) << std::endl;
	return 0;
}
----------------------------------------------------------------------------------------------------------------------------------------