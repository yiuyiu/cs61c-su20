#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
int main(int argc, char **argv)
{
    char *a = (char *)malloc(3 * sizeof(char));
    a[0] = 'a';
    a[1] = 'b';
    a[2] = 'c';
    stringHash(a);
    free(a);
}
int main2(int argc, char **argv)
{
    FILE *fp;

    fp = fopen(argv[1], "r");
    char *word = (char *)malloc(60); // 储存单词的内存空间
    int i = 0;                       // 当前将要插入到数组的索引
    char c;
    while ((c = fgetc(fp)) != EOF)
    {
        // 遇到换行符
        if (c == '\n')
        {
            char *key = (char *)malloc((i + 1) * sizeof(char));
            strcpy(key, word);
            key[i] = '\0';
            // if (findData(dictionary, key) == NULL)
            // {
            //     insertData(dictionary, key, key);
            // }
            i = 0;
            continue;
        }
        word[i] = c;
        i += 1;
    }
    fclose(fp);
    return 0;
}
