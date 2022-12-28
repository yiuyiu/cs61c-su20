/*
 * Include the provided hash table library.
 */
#include "hashtable.h"

/*
 * Include the header file.
 */
#include "philspel.h"

/*
 * Standard IO and file routines.
 */
#include <stdio.h>

/*
 * General utility routines (including malloc()).
 */
#include <stdlib.h>

/*
 * Character utility routines.
 */
#include <ctype.h>

/*
 * String utility routines.
 */
#include <string.h>

/*
 * This hash table stores the dictionary.
 */
HashTable *dictionary;

/*
 * The MAIN routine.  You can safely print debugging information
 * to standard error (stderr) as shown and it will be ignored in
 * the grading process.
 */
int main(int argc, char **argv)
{
  // if (argc != 2)
  // {
  //   fprintf(stderr, "Specify a dictionary\n");
  //   return 0;
  // }
  /*
   * Allocate a hash table to store the dictionary.
   */
  fprintf(stderr, "Creating hashtable\n");
  dictionary = createHashTable(2255, &stringHash, &stringEquals);

  fprintf(stderr, "Loading dictionary %s\n", argv[1]);
  if(argc > 2){
    readDictionary(argv[3]);
  }else{
    readDictionary(argv[1]);
  }
  fprintf(stderr, "Dictionary loaded\n");

  fprintf(stderr, "Processing stdin\n");
  processInput();

  /*
   * The MAIN function in C should always return 0 as a way of telling
   * whatever program invoked this that everything went OK.
   */
  return 0;
}

/*
 * This should hash a string to a bucket index.  Void *s can be safely cast
 * to a char * (null terminated string) and is already done for you here
 * for convenience.
 */
unsigned int stringHash(void *s)
{
  char *string = (char *)s;
  // -- TODO --
  int result = 0;
  while (*string++ != 0)
  {
    result = *string * 31 + result;
  }
  return result;
}

/*
 * This should return a nonzero value if the two strings are identical
 * (case sensitive comparison) and 0 otherwise.
 */
int stringEquals(void *s1, void *s2)
{
  char *string1 = (char *)s1;
  char *string2 = (char *)s2;
  // -- TODO --
  if (strcmp(string1, string2) == 0)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

/*
 * This function should read in every word from the dictionary and
 * store it in the hash table.  You should first open the file specified,
 * then read the words one at a time and insert them into the dictionary.
 * Once the file is read in completely, return.  You will need to allocate
 * (using malloc()) space for each word.  As described in the spec, you
 * can initially assume that no word is longer than 60 characters.  However,
 * for the final 20% of your grade, you cannot assumed that words have a bounded
 * length.  You CANNOT assume that the specified file exists.  If the file does
 * NOT exist, you should print some message to standard error and call exit(1)
 * to cleanly exit the program.
 *
 * Since the format is one word at a time, with new lines in between,
 * you can safely use fscanf() to read in the strings until you want to handle
 * arbitrarily long dictionary chacaters.
 */
void readDictionary(char *dictName)
{
  // -- TODO --
  // 1. 打开文件，获得文件指针
  // 2. 创建单词变量，用于存放单词
  // 3. 利用api获取字符，while获取char
  // 4. 创建每次单词的容器
  // 5. 将获取到的字符拼成单词，检测\n拼成单词，放入容器中
  // 6. 将单词插入hashtable
  FILE *fp = fopen(dictName, "r");
  char *word = (char *)malloc(sizeof(char) * 60);
  char c;
  int i = 0;
  while ((c = fgetc(fp)) != EOF)
  {
    if (c == '\n')
    {
      char *key = (char *)malloc(sizeof(char) * 60);
      word[i] = '\0';
      strcpy(key, word);
      i = 0;
      if (!findData(dictionary, key))
      {
        insertData(dictionary, key, key);
      }
      continue;
    }
    word[i] = c;
    i++;
  }
  free(word);
  fclose(fp);
}

/*
 * This should process standard input (stdin) and copy it to standard
 * output (stdout) as specified in the spec (e.g., if a standard
 * dictionary was used and the string "this is a taest of  this-proGram"
 * was given to stdin, the output to stdout should be
 * "this is a teast [sic] of  this-proGram").  All words should be checked
 * against the dictionary as they are input, then with all but the first
 * letter converted to lowercase, and finally with all letters converted
 * to lowercase.  Only if all 3 cases are not in the dictionary should it
 * be reported as not found by appending " [sic]" after the error.
 *
 * Since we care about preserving whitespace and pass through all non alphabet
 * characters untouched, scanf() is probably insufficent (since it only considers
 * whitespace as breaking strings), meaning you will probably have
 * to get characters from stdin one at a time.
 *
 * Do note that even under the initial assumption that no word is longer than 60
 * characters, you may still encounter strings of non-alphabetic characters (e.g.,
 * numbers and punctuation) which are longer than 60 characters. Again, for the
 * final 20% of your grade, you cannot assume words have a bounded length.
 */
void processInput()
{
  // -- TODO --
  char *str1 = (char *)malloc(sizeof(char) * 60);
  char *str2 = (char *)malloc(sizeof(char) * 60);
  char *str3 = (char *)malloc(sizeof(char) * 60);
  char c;
  int i = 0;
  while ((c = fgetc(stdin)) != EOF)
  {
    if (isalpha(c) != 0)
    {
      str1[i] = c;
      str2[i] = tolower(c);
      str3[i] = i == 0 ? c :(tolower(c));
      i += 1;
    }    else
    {
        str1[i] = '\0';
        str2[i] = '\0';
        str3[i] = '\0';
      // 连续两个非单词 ,加换行这种情况
      if(i == 0){
        fprintf(stdout, "%c", c); 
      }else{
        if (findData(dictionary, str1) == NULL && findData(dictionary, str2) == NULL && findData(dictionary, str3) == NULL)
        {
          fprintf(stdout, "%s [sic]%c", str1, c);
        }
        else
        {
          fprintf(stdout, "%s%c", str1, c);
        }
      }
      i = 0;
    }
  }
  printf("end char is %c", c);
  free(str1);
  free(str2);
  free(str3);
}