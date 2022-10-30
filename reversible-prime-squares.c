/*
	AUTHOR: Poulo Sebolai
	DATE: 01 october 2022
	PROGRAM NAME: reversible-prime-sqaures.c
	

	FUNCTION: The program determines and prints out the first ten reversible prime sqaures.
*/

#include <stdio.h>
#include <math.h>
#include <stdbool.h>

bool is_prime(int num);
int reverse_num(int square_prime);

int main()
{
	long limit = 4000;
		printf("The following are the first ten reversible prime squares: ");
	for (int i=2; i<limit; i++)
	{
		if (is_prime(i) == true)
		{
			int square_prime = i*i;
			int reverse = reverse_num(square_prime);
			int square_root = sqrt(reverse);
			
			if (is_prime(square_root) == true && reverse%square_root == 0 && square_root != i && square_prime<reverse)
			{
			
				printf("%d", square_prime);
				printf(" ");
				printf("%d", reverse);
				printf(" ");
				
			}
		}
	}
	return 0;
}

bool is_prime(int num)
{
		int j=2;
		while (num%j != 0)
		{
			++j;
		}
		if (num == j)
		{
			return true;
		}
		else
			return false;
}

int reverse_num(int square_prime)
{
	int reverse = 0;
	int reminder;
	while (square_prime != 0)
	{
		reminder = square_prime%10;
		reverse = reverse*10 + reminder;
		square_prime/=10;
	}
	return reverse;
}
