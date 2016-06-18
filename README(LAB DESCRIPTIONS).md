# Mips_Assembly_Projects
Various projects created in Mips Assembly language
---------------------------------------------------------------------------------------------------------------------------

CS264 Computer Organization and Assembly Language Programming         Lab#1


Write a program that reads an array of 20 integers with an appropriate prompt, stores it, and then prints in three formats:
- One integer per line; 
-All integers in a single line leaving a space between them;
- You program requests entering a positive integer n <=20 and then prints the 20 integers, n integers (separated by space) per line.

Test your program for one set of 20 integers and for n= 4 and n= 7. Submit a hardcopy of your programs and their outputs. 
###########################################################################################################################

CS264 Computer Organization & Assembly Programming               Lab#2


Write a program that reads (with an appropriate prompt) a sequence of 20  integers and stores them in an array, and then calls the following two functions and prints the results in a readable format. The two functions are: 

smallestLargest:  computes the smallest and the largest values in the array. 

divisible: computes the number of integers in the array, which are divisible by 4. 
###########################################################################################################################

CS264 Computer Organization & Assembly Programming             Lab#3


1. Write a program that reads a string (from a keyboard), stores it in the memory, and computes and prints the frequency of each upper case, each lowercase, and the space character. 
2. Write a function that receives the address of a string and checks whether it it is palindrome or not. Write a program to test this function.

Test your program for at least 3 strings.
###########################################################################################################################

CS264 Computer Organization and Assembly Language Programming          Lab#4 


Write a program in the MIPS assembly language that reads the integers:  -4, -231, 
231, and 65 , and loads them into registers $t0.$t1, $t2, and $t3.  The program performs following operations and prints its result.  Explain the result of each operation using the binary representation and its equivalent decimal value.

###########################################################################################################################

CS264 Computer Organization & Assembly programming         Lab#5


i. Write a program that reads and stores an array of 10 records, each record consists of name of type string of up to 40 characters, age of type integer, and salary of type integer.

 ii. Write a program that prints the array of records of Part(i) in a readable format

iii. Write a program that swaps any adjacent records, and then prints the entire array. The program must ask the user to enter the record numbers to be swapped.  

The following code illustrates how a record can be read, stored, and printed.

#The following reads two records Emp1 and Emp2, each record consists of two attributes 

name and of type string of up to 40 characters and salary of type integer. and then 

prints both records
###########################################################################################################################

CS264 Computer Organization &Assembly Language Programming             Lab#6


1.Write a recursive function that computes the smallest integer in a given array of integers.
Use the following algorithm:

int Min( int[] A, int low, int high)
{   if (low== high) return A[low];
     int mid = (low+high)/2;
     int  min1 = Min( int[] A, low, mid);
     int   min2 =Min( int[] A, mid +1, high);
     if(min1>min2) return min2;
     return min1;
}

2. Write a recursive function that compute the Comb(n,r)  where n >=r and n,r>=0
    Comb(n,r) = 1  if n=r or r=0
    Comb(n,r)= Comb(n-1,r) + Comb( n-1,r-1)

3. Write a program that reads several input data and tests the above two functions. Submit a hardcopy of your program and its output.
###########################################################################################################################











