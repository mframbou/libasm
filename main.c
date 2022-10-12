#include "libasm.h"

#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
	{
		printf("--- ft_strlen ---\n");
		char *str = "Bing chilling";
		printf("ft_strlen(%s) = %lu\n", str, ft_strlen(str));
		printf("ft_strlen(\"\") = %lu\n", ft_strlen(""));
    }

	{
		printf("--- ft_strcpy ---\n");
		char *src = "Beep beep I'm a sheep";
        char dest[ft_strlen(src) + 1];
        char *ret = ft_strcpy(dest, src);
        printf("src: %s\n", src);
        printf("dest: %s\n", dest);
		printf("return value: %s\n", ret);
	}

	{
        printf("--- ft_strcmp ---\n");
        char *s1, *s2;
        s1 = "aaaaaaa", s2 = "z";
        printf("ft_strcmp(%s, %s) = %d (strcmp = %d)\n", s1, s2, ft_strcmp(s1, s2), strcmp(s1, s2));
        s1 = "abcde", s2 = "abcd";
        printf("ft_strcmp(%s, %s) = %d (strcmp = %d)\n", s1, s2, ft_strcmp(s1, s2), strcmp(s1, s2));
        s1 = "abcde", s2 = "abcde";
        printf("ft_strcmp(%s, %s) = %d (strcmp = %d)\n", s1, s2, ft_strcmp(s1, s2), strcmp(s1, s2));
        s1 = "pouet", s2 = "";
        printf("ft_strcmp(%s, %s) = %d (strcmp = %d)\n", s1, s2, ft_strcmp(s1, s2), strcmp(s1, s2));
	}


	{
        printf("--- ft_write ---\n");
        char *str = "Hola me llamo pablo\n";
        printf("%ld\n", ft_write(1, str, ft_strlen(str)));
        printf("errno: %d\n", errno);
    }

	{
        printf("--- ft_read ---\n");
        char buf[100];
        int fd = open("libasm.h", O_RDONLY);
        int ret;

        ret = ft_read(fd, buf, 5);
        if (ret >= 0)
			buf[ret] = 0;
        printf("ret: %d\n", ret);

        if (ret >= 0)
		{
            buf[ret] = 0;
            printf("buf: [%s]\n", buf);
        }
        printf("errno: %s\n", strerror(errno));
        close(fd);

        fd = open("pouet", O_RDONLY);
        ret = ft_read(fd, buf, 5);
        printf("\nret: %d\n", ret);
        if (ret >= 0) {
            buf[ret] = 0;
            printf("buf: [%s]\n", buf);
        }
        printf("errno: %s\n", strerror(errno));
    }

    {
        printf("--- ft_strdup ---\n");
        char *str = "Etttt salut à tous les amis, c'est David Lafarge Pokémon";
        char *dup = ft_strdup(str);
        printf("dup: %s (base str: %s)\n", dup, str);
    }


    {
        printf("--- ft_atoi_base ---\n");
        char *str = "ff";
        char *base = "0123456789abcdef";
        printf("Atoi base(%s, %s) = %d\n", str, base, ft_atoi_base(str, base));
    }

}