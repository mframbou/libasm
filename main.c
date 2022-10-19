#include "libasm.h"

#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

void print_list(t_list *lst)
{
    int i = 0;
    printf("list: ");
    if (!lst)
        printf("(null)");

    while (lst)
    {
        printf("%s%s", i == 0 ? "" : " --> ", lst->data);
        lst = lst->next;
        i++;
    }
    printf("\n");
}

void free_fct(void *data)
{
    printf("Freeing %s\n", data);
    free(data);
}

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
        printf("valid: %ld\n", ft_write(1, str, ft_strlen(str)));
        printf("errno: %s\n", strerror(errno));
        errno = 0;

        printf("\ninvalid: %ld\n", ft_write(-10, str, ft_strlen(str)));
        printf("errno: %s\n", strerror(errno));
        errno = 0;
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
        errno = 0;
        close(fd);

        fd = open("pouet", O_RDONLY);
        ret = ft_read(fd, buf, 5);
        printf("\nret: %d\n", ret);
        if (ret >= 0) {
            buf[ret] = 0;
            printf("buf: [%s]\n", buf);
        }
        printf("errno: %s\n", strerror(errno));
        errno = 0;
    }

    {
        printf("--- ft_strdup ---\n");
        char *str = "Etttt salut à tous les amis, c'est David Lafarge Pokémon";
        char *dup = ft_strdup(str);
        printf("dup: %s (base str: %s)\n", dup, str);
    }


    {
        printf("--- ft_atoi_base ---\n");
        char *str = "abc56";
        char *base = "0123456789";
        printf("Atoi base(%s, %s) = %d\n", str, base, ft_atoi_base(str, base));

        char *str2 = "ffff";
        char *base2 = "0123456789abcdef";
        printf("Atoi base(%s, %s) = %d\n", str2, base2, ft_atoi_base(str2, base2));
    }

    {
        printf("--- ft_list_push_front ---\n");
        t_list *lst = NULL;
        print_list(lst);
        ft_list_push_front(&lst, strdup("test1"));
        print_list(lst);
        ft_list_push_front(&lst, strdup("test2"));
        print_list(lst);
        ft_list_push_front(&lst, strdup("test3"));
        print_list(lst);
    }

    {
        printf("--- ft_list_size ---\n");
        t_list *lst = NULL;
        printf("size of list: %d\n", ft_list_size(lst));
        ft_list_push_front(&lst, strdup("test"));
        printf("size of list: %d\n", ft_list_size(lst));
        ft_list_push_front(&lst, strdup("test"));
        printf("size of list: %d\n", ft_list_size(lst));
    }

    {
        printf("--- ft_list_sort ---\n");
        t_list *lst = NULL;
        ft_list_push_front(&lst, strdup("test2"));
        ft_list_push_front(&lst, strdup("test4"));
        ft_list_push_front(&lst, strdup("test1"));
        ft_list_push_front(&lst, strdup("test3"));
        printf("List before: ");
        print_list(lst);
        ft_list_sort(&lst, &strcmp);
        printf("List after: ");
        print_list(lst);
    }

    {
        printf("--- ft_list_remove_if ---\n");

        t_list *lst = NULL;
        ft_list_push_front(&lst, strdup("0"));
        ft_list_push_front(&lst, strdup("1"));
        ft_list_push_front(&lst, strdup("2"));
        ft_list_push_front(&lst, strdup("3"));
        printf("List before: ");
        print_list(lst);
        ft_list_remove_if(&lst, "1", &strcmp, free_fct);
        printf("List after: ");
        print_list(lst);
    }

}