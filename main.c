#include "libasm.h"

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
}